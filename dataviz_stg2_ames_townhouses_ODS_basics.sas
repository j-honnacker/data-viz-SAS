
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

