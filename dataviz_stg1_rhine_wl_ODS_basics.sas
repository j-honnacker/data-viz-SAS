

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


