libname raw '/scratch/fatemehkp/projects/USA Spatial/data/raw';
libname prcs '/scratch/fatemehkp/projects/USA Spatial/data/processed';

proc import datafile="/scratch/fatemehkp/projects/USA Spatial/data/processed/ses-site-bz12.csv"
        out=ses_bz12
        dbms=csv
        replace;
     getnames=yes;
run;

* change names to be consistent with CMS data;
data prcs.ses_site_bz12;
	set ses_bz12;
	Site_ID = Site.ID;
	ses_zip_u = SES.Zip.UNorm;
	ses_zip_n = SES.Zip.Norm;
	ses_stt = SES.State;
	keep Site_ID Year ses_zip_u ses_zip_n ses_stt;
run;

