
%let path = /sas/homes/data-viz-SAS;
%let path = /folders/myfolders/data-viz-SAS;
libname d_stg1 "&path./data_stg1";

/******************************************************************************/
/* (1) Read Data
/******************************************************************************/

%macro ames_my_import
(
	input_file_desc =
,	input_file      =
,	output_sas      =
);

	%local i;


	/* Read data file specifications
	*/
	proc import
		datafile     = "&input_file_desc."
		out          = _ames_desc( drop = Pos )
		dbms         = xlsx
		replace
	;
	run;
	
	
	/* Save data file specifications in macro variables
	*/
	data _null_;
	
		set _ames_desc end  = eof;
	
		call symputx(cats("var", _N_, "_name"    ), Variable);
		call symputx(cats("var", _N_, "_length"  ), Len);
		call symputx(cats("var", _N_, "_informat"), Informat);
		call symputx(cats("var", _N_, "_label"   ), Label);
		
		if eof;
		call symputx("number_of_vars", _N_);
	run;
	
	proc delete data = _ames_desc; run;
	

	/* Apply data file specifications to read data file
	*/
	data &output_sas.;
	
		infile
			"&input_file."
			dsd
			truncover
			lrecl     = 32767
			firstobs  = 2
		;
	
		attrib
			%do i=1 %to &number_of_vars.;
				&&var&i._name.
					length =  &&var&i._length.
					label  = "&&var&i._label."
			%end;
		;
		
		input
			%do i=1 %to &number_of_vars.;
				&&var&i._name. :&&var&i._informat.
			%end;
		;
	
	run;

%mend;

%ames_my_import(
	input_file_desc = &path./data_stg0/AmesHousing-desc.xlsx
,	input_file      = &path./data_stg0/AmesHousing.csv
,	output_sas      = ames
);


/******************************************************************************/
/* (2) Pre-Process data
/******************************************************************************/

proc sgplot
	data = ames
;
	scatter
		x = Gr_Liv_Area
		y = SalePrice
	/	markerattrs  = ( symbol = CircleFilled )
		transparency = .75
	;
run;

data ames;
	set ames( where = (Gr_Liv_Area <= 4000) );
run;


/******************************************************************************/
/* (3) Save data
/******************************************************************************/

proc copy
	in  = work
	out = d_stg1
;
	select ames;
run;


/******************************************************************************/
/* Appendix
/******************************************************************************/

%macro proc_import_approach;

	proc import
		datafile     = "&path./data_stg0/AmesHousing.csv"
		out          = ames_csv
		dbms         = csv
	;
		guessingrows = 3000;
	run;

	proc import
		datafile     = "&path./data_stg0/AmesHousing.xls"
		out          = ames_xls
		dbms         = xls
	;
		guessingrows = 3000;
	run;

%mend;

