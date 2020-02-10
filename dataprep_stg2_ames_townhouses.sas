
%let path = /sas/homes/data-viz-SAS;
%let path = /folders/myfolders/data-viz-SAS;

libname d_stg1 "&path./data_stg1";
libname d_stg2 "&path./data_stg2";



/* (1) Apply "townhouse conditions ********************************************/

data townhouses;

	set d_stg1.ames
	(
		where =
		(
			Bldg_Type in ('TwnhsE', 'Twnhs') and
			Functional in ('Typ', 'Min1', 'Min2') and
			Bedroom_AbvGr >= 1 and
			Kitchen_AbvGr >= 1 and
			Overall_Qual  >= 5 and
			Overall_Cond  >= 5
		)
	);

	Full_Bathrooms = Bsmt_Full_Bath + Full_Bath;
	Half_Bathrooms = Bsmt_Half_Bath + Half_Bath;

run;



/* (2) Get rid off categories with too few values *****************************/


/* (2.1) Categorical variables (1/2) -----------------------------------------*/


/* Explore bathroom variables
*/
proc freq
	data = townhouses
;
	table
		Full_Bathrooms
	*	Half_Bathrooms
	/	
		nocol  /* w/o/ column percentages */
		norow  /* w/o/ row percentages    */	
	;
run;


/* Adjust
*/
data townhouses;

	set townhouses
	(
		where =
		(
			( Full_Bathrooms between 1 and 3 ) and
			( Half_Bathrooms between 0 and 1 )
		)
	);
run;


/* Check out adjusted data
*/
proc freq
	data = townhouses
;
	table
		Full_Bathrooms
	*	Half_Bathrooms
	/	
		nocol    /* w/o/ column percentages */
		norow    /* w/o/ row percentages    */
		missing  /* include missing values  */
	;
run;



/* (2.2) Categorical variables (2/2) -----------------------------------------*/

%let categorical_vars =
	Functional Overall_Qual Overall_Cond House_Style
	Bedroom_AbvGr
	Kitchen_AbvGr Kitchen_Qual
	Garage_Type
	Fireplaces
;


/* Explore
*/
proc freq
	data  = townhouses
	order = freq  /* order by frequencies */ 
;
	table
		&categorical_vars.
	/
		missing  /* include missing values */
	;
run;


/* Adjust
*/
data townhouses;

	set townhouses
	(
		where =
		(
			( Bedroom_AbvGr between 1 and 3 ) and
			Garage_Type in ('Attchd', 'Detchd') and
			House_Style in ('1Story', '2Story') and
			( Fireplaces between 0 and 1 )
		)
	) ;
run;


/* Check out adjusted data
*/
proc freq
	data  = townhouses
	order = freq  /* order by frequencies */ 
;
	table
		&categorical_vars.
	/
		missing  /* include missing values */
	;
run;



/* (2.3) Continuous variables ------------------------------------------------*/

%let continuous_vars = 
	Lot_Area
	Total_Bsmt_SF
	SalePrice
;


/* Explore
*/
%macro explore_continuous_vars;

	/* Create a histogram for each variable in &continuous_vars.
	*/
	%do i = 1 %to %sysfunc(countw( &continuous_vars. ));

		%let var = %scan( &continuous_vars., &i. );

		proc sgplot
			data = townhouses
		;
			histogram
				&var.
			/
				scale = count /* display frequencies */
			;
		run;
	%end;

%mend;
%explore_continuous_vars;


/* Adjust
*/
data townhouses;
	set townhouses
	(
		where =
		(
			Total_Bsmt_SF > 0
		)
	);
run;


/* Check out adjusted data
*/
%explore_continuous_vars;



/* (3) Write final data set to data_stg2 location *****************************/
%let vars =
	/* Discrete */
	Year_Built
,	Year_Remod_Add
,	Yr_Sold
,	Full_Bathrooms
,	Half_Bathrooms
,	Bedroom_AbvGr
,	Kitchen_AbvGr
,	Fireplaces

	/* Ordinal */
,	Functional
,	Overall_Qual
,	Overall_Cond
,	Kitchen_Qual

	/* Nominal */
,	House_Style
,	Garage_Type

	/* Continuous */
,	Lot_Area
,	Total_Bsmt_SF
,	SalePrice
;

proc sql;

	create table
		d_stg2.ames_townhouses
	as
		select
			&vars.
		from
			townhouses
	;

quit;