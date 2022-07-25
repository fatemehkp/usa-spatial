libname raw '/scratch/fatemehkp/projects/USA Spatial/data/raw';
libname prcs '/scratch/fatemehkp/projects/USA Spatial/data/processed';

proc import datafile="/scratch/fatemehkp/projects/data/processed/ses_zip.csv"
        out=ses
        dbms=csv
        replace;
     getnames=yes;
run;

* change names to be consistent with CMS data;
data prcs.ses_zipcd;
	set ses;
	ZIP_CODE = Zip.Code;
	ses_zip = SES.Zip.Norm;
	ses_stt = SES.State;
	/*ses_zip_un = SES.Zip.Unorm;*/
	keep ZIP_CODE Year ses_zip ses_stt;
run;


* Adding urbanicty;
proc sql;
	create table ses_urb as
	select *
	from prcs.ses_zipcd a
	inner join prcs.urbanicity_zipcd b
	on a.zip_code=b.zip_code;
quit;

proc rank data = ses_urb out=prcs.ses_zipcd_urban_cat (drop = urban)
    groups = 3;
   	var ses_zip;
   	ranks ses_tertile;
   	where urban = 1;
run; 

