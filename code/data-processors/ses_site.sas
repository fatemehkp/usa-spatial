libname raw '/scratch/fatemehkp/projects/data/raw';
libname prcs '/scratch/fatemehkp/projects/data/processed';

proc import datafile="/scratch/fatemehkp/projects/data/raw/ses-site-bz6.csv"
        out=ses_bz6
        dbms=csv
        replace;
     getnames=yes;
run;

* change names to be consistent with CMS data;
data prcs.ses_site_bz6;
	set ses;
	Site_ID = Site.ID;
	ses_zip_u = SES.Zip.UNorm
	ses_zip_n = SES.Zip.Norm;
	ses_stt = SES.State;
	keep ZIP_CODE Year ses_zip_u ses_zip_n ses_stt;
run;

