
libname prcs '/scratch/fatemehkp/projects/USA Spatial/data/processed';

proc import datafile = '/scratch/fatemehkp/projects/USA Spatial/data/processed/brfss-zip.csv'
 out = brfss_zipcd
 dbms = csv;
run;

* change names to be consistent with CMS data;
data prcs.brfss_zipcd;
	set brfss_zipcd;
	ZIP_CODE = Zip.Code;
	drop 'Zip.Code'n;
run;


proc sql;
	title "Total number of zipcodes with complete BRFSS-2008";
	select count(distinct zip_code)/*16,218*/
	from prcs.brfss_zipcd;
quit;

