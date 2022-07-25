libname prcs '/scratch/fatemehkp/projects/USA Spatial/data/processed';

proc import datafile="/scratch/fatemehkp/projects/USA Spatial/data/raw/us_states.csv"
        out=us_states
        dbms=csv
        replace;
     getnames=yes;
run;

data prcs.us_states;
	set us_states;
run;

* change names to be consistent with CMS data;
data prcs.region_state;
	set us_states;
	region = region_iv;
	keep state region;
run;

