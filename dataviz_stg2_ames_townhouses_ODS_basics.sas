
%let path = D:\data-viz-SAS;

libname d_stg2 "&path.\data_stg2";

%let vars =
	/* Discrete */
	Year_Built
	Year_Remod_Add
	Yr_Sold
	Full_Bathrooms
	Half_Bathrooms
	Bedroom_AbvGr
	Kitchen_AbvGr
	Fireplaces

	/* Ordinal */
	Functional
	Overall_Qual
	Overall_Cond
	Kitchen_Qual

	/* Nominal */
	House_Style
	Garage_Type

	/* Continuous */
	Lot_Area
	Total_Bsmt_SF
	SalePrice
;



/* Scatter Plot with Prediction Ellipse  -------------------------------------*/

%let var_y     = SalePrice;
%let var_x     = Total_Bsmt_SF;
%let var_color = Year_Built;


proc sgplot
	data = d_stg2.ames_townhouses
;
	scatter
		x = &var_x.
		y = &var_y.
	/
		colorresponse = &var_color.
		colormodel    = TwoColorRamp

		markerattrs   = ( symbol = CircleFilled
		                  size   = 10
		                )
		
		filledoutlinedmarkers
	;
	ellipse
		x = &var_x.
		y = &var_y.
	;
run;



/* Box Plots, grouped  -------------------------------------------------------*/

%let var_y     = SalePrice;
%let var_x     = Yr_Sold;
%let var_group = House_Style;

proc sgplot
	data = d_stg2.ames_townhouses
;
   vbox
		&var_y.
	/
		category = &var_x.
		group    = &var_group.
	;
run;



/* Bar Chart, grouped  -------------------------------------------------------*/

%let var_y     = SalePrice;
%let var_x     = Full_Bathrooms;
%let var_group = Fireplaces;

proc sgplot
	data = d_stg2.ames_townhouses
;

	vbar	
		&var_x.
	/
		response = &var_y.
		stat     = mean

		group        = &var_group.
		groupdisplay = cluster
	;
run;

