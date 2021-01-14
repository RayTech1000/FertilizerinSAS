libname tree 'folders/myfolders';


/* Generated Code (IMPORT) */
/* Source File: fertilizertrt.xlsx */
/* Source Path: /folders/myfolders */

%web_drop_table(WORK.IMPORT);


*Reading in the data. The fertilizer data is in excel format. 
This code is automatically generated when you select it from the 'my folders' link;
FILENAME REFFILE '/folders/myfolders/fertilizertrt.xlsx';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLSX
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;


*Checking on the data with proc contents.
This fertilizer data is divided up in treatments and yields;
PROC CONTENTS DATA=WORK.IMPORT; 
RUN;


*Fit the data with a statistical model with all the main effects and interaction effects. 
pipes '|' will display every effect;
PROC ANOVA data = import;
CLASS TrtA TrtB TrtC;
MODEL Yield1 = TrtA|TrtB|TrtC ;
run;



*Fitting the data with a statistical model with all significant main effects and
interaction effects with the model Yield1 = TrtA;
PROC ANOVA data = import;
CLASS TrtA TrtB TrtC;
MODEL Yield1 = TrtA;
run;



*Checking for the lowest yields for TrtA with alpha=0.01 and with Scheffe's method;
PROC ANOVA data = import;
CLASS TrtA TrtB TrtC;
MODEL Yield1 = TrtA;
MEANS TrtA / clm Scheffe alpha=0.01;
run;
*
Trta	N	Mean	Simultaneous 99% Confidence Limits
a2	6	42.700	37.716	47.684
a1	6	41.233	36.249	46.217
a3	6	38.417	33.433	43.401
a0	6	36.000	31.016	40.984

The lowest average yield1 is a0;



*Checking for the lowest yields for TrtA with alpha=0.01 and with Duncan's method;
PROC ANOVA data = import;
CLASS TrtA TrtB TrtC;
MODEL Yield1 = TrtA;
MEANS TrtA / Duncan alpha=0.1;
run;
*a2 and a1 are the highest average yields;



PROC ANOVA data = import;
CLASS TrtA TrtB TrtC;
MODEL Yield1 = TrtC;
MEANS TrtC / t alpha=.025;
run;
*c1 is the highest average sample yield at 40.03;



*Checking for the lowest yields for TrtA with alpha=0.025 and Tukey's range test;
PROC ANOVA data = import;
CLASS TrtA TrtB TrtC;
MODEL Yield1 = TrtA;
MEANS TrtA / Tukey alpha=.025;
run;
*a2, a1, and a3 have the highest average yields;



*Checking for the lowest yields for TrtA with alpha=0.025 and with Dunnett's test;
PROC ANOVA data = import;
CLASS TrtA TrtB TrtC;
MODEL Yield1 = TrtA;
MEANS TrtA / Dunnett alpha=.025;
run;
/*
a2 - a0	6.700	1.896	11.504	***
a1 - a0	5.233	0.429	10.038	***

a2 and a1 are the significantly different yields
*/

