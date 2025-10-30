clear
use "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\final dataset\dataset final - hospital data.dta" 

cd "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\individual young"

set scheme cleanplots, permanently

*now, not yet treated as control units (5 april 2023)

*use initial size

sort team_id date
gen initial_members=team_member if date==tm(2016m1)
replace initial_members=team_member if team_id!=team_id[_n-1]
replace initial_members=initial_members[_n-1] if team_id==team_id[_n-1]

*codebook CDMATR

*young staff in large teams

drop if team_member< 3

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==5 | job_description_code==19
keep if birth>1986
keep if initial_members<75 & initial_members>14


sum tot_minutes if treatment_team_mate==1

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0

*pre-treatment average minutes

sum tot_minutes if D_1==1

*event study estimation

xtreg log_minutes D_7-D_2 x D0-D7 i.date days_ab, fe cluster(CDMATR) level(95) robust

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(large)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.2(0.1)0.2) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium)) ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Young Nurses in Large Teams", size(large)) saving(graph_1_young.gph, replace)
restore

*young staff in small teams

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==5 | job_description_code==19
keep if birth>1986
keep if initial_members<15


tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0

sum tot_minutes if treatment_team_mate==1

xtreg log_minutes D_7-D_2 x D0-D7 i.date days_ab, fe cluster(CDMATR) level(95) robust

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(large)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.2(0.1)0.2) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Young Nurses in Small Teams", size(large)) saving(graph_2_young.gph, replace)
restore

gr combine graph_1_young.gph graph_2_young.gph, ycommon
graph export "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\individual young\spillover_effect_event_study_young_routine_large_small.png", as(png) name("Graph") replace

*young doctors in small teams

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==15
keep if birth>1981
keep if initial_members<11


tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0

sum tot_minutes if treatment_team_mate==1

xtreg log_minutes D_7-D_2 x D0-D7 i.date days_ab, fe cluster(CDMATR) level(95) robust

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(large)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.2(0.1)0.2) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Young Doctors in Small Teams", size(large)) saving(graph_4_young.gph, replace)
restore

*young doctors in large teams

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==15
keep if birth>1978
keep if initial_members>10 & initial_members<21

tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0

sum tot_minutes if treatment_team_mate==1

xtreg log_minutes D_7-D_2 x D0-D7 i.date days_ab, fe cluster(CDMATR) level(95) robust

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(large)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.2(0.1)0.2) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Young Doctors in Large Teams", size(large)) saving(graph_3_young.gph, replace)
restore

gr combine graph_3_young.gph graph_4_young.gph, ycommon
graph export "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\individual young\spillover_effect_event_study_young_specilized_large_small.png", as(png) name("Graph") replace

****************GRAPH COMBINE DIFFERENT TASKS DIFFERENT SIZE********************

gr combine graph_1_young.gph graph_2_young.gph graph_3_young.gph graph_4_young.gph, ycommon
graph export "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\individual young\spillover_effect_event_2_types_2_size_young.png", as(png) name("Graph") replace

   
*****Full sample (small+large teams)
   
*young staff

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==5 | job_description_code==19
keep if birth>1986
keep if initial_members<75


tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0

sum tot_minutes if D_1==1

xtreg log_minutes D_7-D_2 x D0-D7 i.date days_ab, fe cluster(CDMATR) level(95) robust

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(large)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.2(0.1)0.2) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Young Nurses", size(large)) saving(graph_all_staff.gph, replace)
graph export spillover_effect_event_study_young_routine.png, replace
restore

*young doctors 
 
   
preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==15
keep if birth>1978
keep if initial_members<20


tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0

sum tot_minutes if treatment_team_mate==1

xtreg log_minutes D_7-D_2 x D0-D7 i.date days_ab, fe cluster(CDMATR) level(95) robust

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(large)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.2(0.1)0.2) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white))title("Young Doctors", size(large)) saving(graph_all_doctors.gph, replace)
graph export spillover_effect_event_study_young_specialized.png, replace
restore


*******COMBINE GRAPHS ALL GRAPHS HETEROGENOUS SIZE, HOMOGENOUS SIZE, HETEROGGENOUS JOBS***********


gr combine graph_all_staff.gph graph_all_doctors.gph, ycommon
graph export "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\individual young\spillover_effect_event_graphs_2_types_1_size_young.png", as(png) name("Graph") replace
   
   
   
   /*-------------------------------------------------------
---------------------------------------------------------
+++++++++++++++ DIFF IN DIFF ++++++++++++++++++++++++++++
---------------------------------------------------------
---------------------------------------------------------
*/

*young staff in large teams
preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==5 | job_description_code==19
keep if birth>1986
keep if initial_members<75 & initial_members>15



tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0

replace D0=D0+D1+D2+D3+D4+D5+D6


xtreg log_minutes D_7-D_2 x D0 D7 i.date days_ab, fe cluster(CDMATR) level(95) robust
estimates store staff_large_young, title(Young Staff in Large Teams)

restore


*young staff in small teams

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==5 | job_description_code==19
keep if birth>1986
keep if initial_members<16



tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0

replace D0=D0+D1+D2+D3+D4+D5+D6



xtreg log_minutes D_7-D_2 x D0 D7 i.date days_ab, fe cluster(CDMATR) level(95) robust

estimates store staff_small_young, title(Young Staff in Small Teams)

restore


*young doctors in large teams

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==15
keep if birth>1978
keep if initial_members>10 & initial_members<20



tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0

replace D0=D0+D1+D2+D3+D4+D5+D6


xtreg log_minutes D_7-D_2 x D0 D7 i.date days_ab, fe cluster(CDMATR) level(95) robust

estimates store doctors_small_young, title(Young Doctors in Small Teams)

restore

*young doctors in small teams

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==15
keep if birth>1978
keep if initial_members<11



tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0

replace D0=D0+D1+D2+D3+D4+D5+D6



xtreg log_minutes D_7-D_2 x D0 D7 i.date days_ab, fe cluster(CDMATR) level(95) robust
estimates store doctors_large_young, title(Young Doctors in Large Teams)

restore

cd "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\tables"


*esttab staff_large_young staff_small_young doctors_large_young doctors_small_young using diff_in_diff_young_health_shock.tex , cells(b(star fmt(3)) se(par fmt(2))) keep(D0) ///
   *legend label varlabels(_cons Constant) 


   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
**normal health shocks

cd "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\individual health shocks"

preserve
tab health_shock
*replace health_shock=18 if health_shock==0

gen H_6=1 if health_shock==0
replace H_6=0 if H_6==.

gen H_5=1 if health_shock==1
replace H_5=0 if H_5==.

gen H_4=1 if health_shock==2
replace H_4=0 if H_4==.

gen H_3=1 if health_shock==3
replace H_3=0 if H_3==.

gen H_2=1 if health_shock==4
replace H_2=0 if H_2==.

gen H_1=1 if health_shock==5
replace H_1=0 if H_1==.

gen H0=1 if health_shock==6
replace H0=0 if H0==.

gen H1=1 if health_shock==7
replace H1=0 if H1==.

gen H2=1 if health_shock==8
replace H2=0 if H2==.

gen H3=1 if health_shock==9
replace H3=0 if H3==.

gen H4=1 if health_shock==10
replace H4=0 if H4==.

gen H5=1 if health_shock==11
replace H5=0 if H5==.

gen H6=1 if health_shock==12
replace H6=0 if H6==.

gen H7_plus=1 if health_shock==15
replace H7_plus=0 if H7_plus==.

gen x=1

*replace tot_hours=log(tot_hours)

drop if treatment_health_shock==0 & treatment_team_mate==1

xtreg tot_hours H7_plus H_6-H_2 x H0-H6, fe cluster(CDMATR)

coefplot, vertical keep(H_6 H_5 H_4 H_3 H_2 x H0 H1 H2 H3 H4 H5 H6) yline(0) levels(95) coeflabels(H_6="-6" H_5 ="-5" H_4 ="-4" H_3 ="-3" H_2 ="-2" H_1 ="-1" H0 ="0" H1 ="1" H2 ="2" H3 ="3" H4 ="4" H5="5" H6="6") ytitle("Change in Hours", size(medium)) xtitle("Time to individual shock", size(medium) yoffset(-2)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-150(25)0) xscale(lc(black)) scale(1)  yline(0, lcolor(black)) plotregion(fcolor(white)) ciopts(recast(rcap) lc(black) fcolor(white)) title("Individual Health Shocks", size(large))
graph export individual_health_shocks.png, replace


restore

