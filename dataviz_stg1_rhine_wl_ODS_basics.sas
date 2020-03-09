

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
/
	antialiasmax = 8500
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



/* Moving averages  ----------------------------------------------------------*/


/* (1) Calculate moving averages
*/
proc expand
    data = rhine_wl_1996_2018
    out  = rhine_wl_1996_2018_ma
    method = none
;
    id
		date
	;
    convert
		water_level = water_level_50days
	/
		transout = ( movave    50   /* Calculate 50 days moving average */
		             trimleft  49 ) /* ...except for the fist 49 days   */
	;
    convert
		water_level = water_level_200days
	/
		transout = ( movave   200   /* Calculate 200 days moving average */
		             trimleft 199 ) /* ...except for the first 199 days  */
	;

run;


/* (2) Plot pre-processed data
*/
%let var_x  = date;
%let var_y1 = water_level;
%let var_y2 = water_level_50days;
%let var_y3 = water_level_200days;


/* Set width and height */
ods
	graphics on
/
	width  = 28cm
	height = 16cm
;


/* Create (2a) scatter plot based on &var_y1.
          (2b) blue line plot based on &var_y2.
          (2c) red line plot based on &vart_y3. */
proc sgplot
	data = rhine_wl_1996_2018_ma
;

	/* (2a) */
	scatter
		x = &var_x.
		y = &var_y1.
	/
		markerattrs  = ( symbol = CircleFilled
		                 size   = 5pt
		                 color  = lightgray
		               )
		transparency = .6
	;

	/* (2b) */
	series
		x = &var_x.
		y = &var_y2.
	/
		name         = "50d"
		legendlabel  = "50-Day Moving Average"
		lineattrs    = ( color     = blue
		                 thickness = 3
		               )
		transparency = .4
	;

	/* (2c) */
	series
		x = &var_x.
		y = &var_y3.
	/
		name         = "200d"
		legendlabel  = "200-Day Moving Average"
		lineattrs    = ( color     = red
		                 thickness = 3
		               )
		transparency = .4
	;

	title
		"Daily Water Levels of the Rhine Near Duesseldorf, Germany"
	;
	xaxis
		label = "Date"
	;
	yaxis
		label = "Water Level in cm"
	;
	keylegend
		"50d"
		"200d"
	/
		across = 1
	;

run;


/* Reset title and ODS settings */
title;

ods
	graphics on
/
	reset  = width
	         height
;



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

