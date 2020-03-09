

%let path = /sas/homes/data-viz-sas;
%let path = /folders/myfolders/data-viz-SAS;

libname data "&path./data_stg1";



/* Read and enrich data set
*/
data rhine_wl_1996_2018;

	set
		data.rhine_wl_1996_2018
	;

	year    = year(date);
	month   = month(date);
	quarter = qtr(date);

run;



/* Set (ODS) graphics settings
*/
ods
	graphics on
	/	width=32cm height=16cm
;



/* LINE CHART  ---------------------------------------------------------------*/

%let var_x = date;
%let var_y = water_level;


proc sgplot
	data = rhine_wl_1996_2018
;
	series
		x = &var_x.
		y = &var_y.
	;
	format
		date date11.
	;
	xaxis values=('1jan96'd to '1dec18'd by year);
	*refline '1jan97'd / axis=x;
	*refline '1jan98'd / axis=x;
run;



/* Yearly BAR CHARTS  --------------------------------------------------------*/

%let var_x = year;
%let var_y = water_level;


proc sgplot
	data = rhine_wl_1996_2018
;

	vbar
		&var_x.
	/	response = &var_y.
		stat     = mean
	;

run;



/* Quarterly BAR CHARTS for each year between 1996 and 2000 ------------------*/

%let var_x1 = year;
%let var_x2 = quarter;
%let var_y  = water_level;


proc sgpanel
	data = rhine_wl_1996_2018( where=(1996 <= year <= 2000) )
;
	panelby
		&var_x1.
	/	layout      = columnlattice
		onepanel
		colheaderpos = bottom
		rows         = 4
		novarname
		noborder
	;

	vbar
		&var_x2.
	/	group    = quarter
		response = &var_y.
		stat     = mean
		nostatlabel
	;

	colaxis
		display = none
	;
	rowaxis
		grid
	;

run;



/* BOX PLOTS by month  -------------------------------------------------------*/

%let var_x = month;
%let var_y = water_level;


proc sgplot
	data = rhine_wl_1996_2018
;
	vbox
		&var_y.
	/	category = &var_x.
	;

run;



/* Moving averages  ----------------------------------------------------------*/


/* Pre-processing
*/
proc expand
    data = rhine_wl_1996_2018
    out  = rhine_wl_1996_2018_ma
    method = none
;
    id date;
    convert
		water_level = water_level_100days
	/
		transout = ( movave   100   /* Calculate 10 days moving average */
		             trimleft  99 ) /* ...except for the fist 9 days    */
	;
    convert
		water_level = water_level_200days
	/
		transout = ( movave   200   /* Calculate 30 days moving average */
		             trimleft 199 ) /* ...except for the first 29 days  */
	;

run;


/* Plot pre-processed data
*/
%let var_x  = date;
%let var_y1 = water_level;
%let var_y2 = water_level_100days;
%let var_y3 = water_level_200days;


proc sgplot
	data = rhine_wl_1996_2018_ma
;

	scatter
		x = &var_x.
		y = &var_y1.
	/
		legendlabel     = "water level"
		markerattrs     = ( symbol = CircleFilled
		                    size   = 2pt
		                  )
		markerfillattrs = ( color = black )
	;
	series
		x = &var_x.
		y = &var_y2.
	/
		legendlabel  = "100 days moving average"
		lineattrs    = ( color     = blue
		                 thickness = 3
		               )
		transparency = .5
	;
	series
		x = &var_x.
		y = &var_y3.
	/
		legendlabel  = "200 days moving average"
		lineattrs    = ( color     = orange
		                 thickness = 3
		               )
		transparency = .5
	;

run;
