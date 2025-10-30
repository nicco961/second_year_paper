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
keep if initial_members<75 & initial_members>10


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

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(large)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.2(0.1)0.3) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium)) ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Young Nurses in Large Teams", size(large)) saving(graph_1_young.gph, replace)
restore

*young staff in small teams

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==5 | job_description_code==19
keep if birth>1986
keep if initial_members<10


tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0

sum tot_minutes if treatment_team_mate==1

xtreg log_minutes D_7-D_2 x D0-D7 i.date days_ab, fe cluster(CDMATR) level(95) robust

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(large)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.2(0.1)0.3) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Young Nurses in Small Teams", size(large)) saving(graph_2_young.gph, replace)
restore

gr combine graph_1_young.gph graph_2_young.gph, ycommon

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

sum tot_minutes if treatment_team_mate==1

xtreg log_minutes D_7-D_2 x D0-D7 i.date days_ab, fe cluster(CDMATR) level(95) robust

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(large)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.2(0.1)0.3) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Young Doctors in Small Teams", size(large)) saving(graph_4_young.gph, replace)
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

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(large)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.2(0.1)0.3) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Young Doctors in Large Teams", size(large)) saving(graph_3_young.gph, replace)
restore

gr combine graph_3_young.gph graph_4_young.gph, ycommon

****************GRAPH COMBINE DIFFERENT TASKS DIFFERENT SIZE********************

gr combine graph_1_young.gph graph_2_young.gph graph_3_young.gph graph_4_young.gph, ycommon
graph export "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\robustness checks\change size\robustness_spillover_effect_event_2_types_2_size_young.png", as(png) name("Graph") replace

   