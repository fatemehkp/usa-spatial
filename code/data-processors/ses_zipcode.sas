libname raw '/scratch/fatemehkp/projects/data/raw';
libname prcs '/scratch/fatemehkp/projects/data/processed';

proc import datafile="/scratch/fatemehkp/projects/data/raw/ses_zip.csv"
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
	keep ZIP_CODE Year ses_zip ses_stt;
run;
