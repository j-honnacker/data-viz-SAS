
%macro create_rhine_data
(
	in_CSVs =
,	out_SAS =
);

	libname out "&out_SAS.";

	%let months =
		Januar  Februar  Maerz
		April   Mai      Juni
		Juli    August   September
		Oktober November Dezember
	;

	data rhine_wl_1996_2018;
		attrib
			date        format = date11.
			water_level length = 8
		;
		stop;
	run;

	%do year = 1996 %to 2018;

		%if &year. = 2018 %then %let file = &in_CSVs./Rheinpegel_Tag&year..csv;
		                  %else %let file = &in_CSVs./Rheinpegel_Tag &year..csv;

		data _null_;

			attrib
				date        format = date11.
				water_level length = 8
			;

			declare hash
				hsh(ordered:'y');
				hsh.DefineKey('date');
				hsh.DefineData('date', 'water_level');
				hsh.DefineDone();

			do until(done_reading);

				infile
					"&file."
					dsd
					truncover
					lrecl     = 50
					termstr   = CRLF
					firstobs  = 2
					dlm       = ";"
					end        = done_reading
				;

				input
					Tag :2.
					%do month = 1 %to 12;
						%scan(&months., &month.) :3.
					%end;
				;


				%do month = 1 %to 12;
					date = input(cats("&year.",put(&month.,z2.),put(Tag,z2.)),??yymmdd8.);
					if date ne . then do;
						water_level = %scan(&months., &month.);
						hsh.add();
					end;
				%end;

			end;

			hsh.output(dataset:'wl');

		run;

		proc append
			base = out.rhine_wl_1996_2018
			data = wl
		;
		run;

	%end;

	proc delete data=wl; run;

%mend;

%let path = /sas/homes/data-viz-sas;


%create_rhine_data
(
	in_CSVs = &path./data_src/Rhine-water-levels
,	out_SAS = &path./data
);