

%let path = /sas/homes/data-viz-sas;
%let path = /folders/myfolders/data-viz-SAS;

libname data "&path./data";


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


/* Plot the WHOLE THING as a LINE CHART
*/
proc sgplot
	data = rhine_wl_1996_2018
;
	series
		x = date
		y = water_level
	;
	format
		date date11.
	;
	xaxis values=('1jan96'd to '1dec18'd by year);
	*refline '1jan97'd / axis=x;
	*refline '1jan98'd / axis=x;
run;


/* Create a BAR CHART of the WHOLE THING by YEAR
*/
proc sgplot
	data = rhine_wl_1996_2018
;

	vbar
		year
	/	response = water_level
		stat     = sum
	;

run;


/* QUARTERLY BAR CHARTS for EACH YEAR between 1996 and 2000
*/
proc sgpanel
	data = rhine_wl_1996_2018( where=(1996 <= year <= 2000) )
;
	panelby
		year
	/	layout      = columnlattice
		onepanel
		colheaderpos = bottom
		rows         = 4
		novarname
		noborder
	;

	vbar
		quarter
	/	group    = quarter
		response = water_level
		stat     = sum
		nostatlabel
	;

	colaxis
		display = none
	;
	rowaxis
		grid
	;

run;


/* Create BAR CHARTS for the WHOLE THING by MONTH
*/
proc sgplot
	data = rhine_wl_1996_2018
;
	vbox
		water_level
	/	category = month
	;

run;

