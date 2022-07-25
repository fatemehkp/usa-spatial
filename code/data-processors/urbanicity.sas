libname raw '/scratch/fatemehkp/projects/USA Spatial/data/raw';
libname prcs '/scratch/fatemehkp/projects/USA Spatial/data/processed';


proc import datafile= "/scratch/fatemehkp/projects/USA Spatial/data/raw/RUCA2004.csv"
	out= prcs.urbanicity_zipcd
	dbms=csv 
	REPLACE;
	getnames=YES;
	datarow=2;
run;

proc freq data=prcs.urbanicity_zipcd;
	table USR;
run;

/*
USR	Frequency Percent	
1 - Urban 	 15107		50.18	
2 - Micropol 4130		13.72	
3 - Rural    10867		36.10	
*/

data prcs.urbanicity_zipcd; 
	length zip $5; 
	set prcs.urbanicity_zipcd;
	zip=put(input(zip_code, best12.),z5.);
	drop zip_code;
run;

data prcs.urbanicity_zipcd; 
	set prcs.urbanicity_zipcd;
	rename zip=zip_code;
run;

/* urban-> urban=1 - non-urban-> urban=0 */
data prcs.urbanicity_zipcd; 
	set prcs.urbanicity_zipcd;
	if USR=1 then urban=1; 
		else urban=0;
	drop USR;
run;

proc sort data=prcs.urbanicity_zipcd nodupkey; 
	by zip_code; 
run;

proc freq data=prcs.urbanicity_zipcd;
	table urban;
run;

/*
1	15107	50.18	
0	14997	49.82	
*/





