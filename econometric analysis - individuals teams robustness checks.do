clear
use "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\final dataset\dataset final - hospital data.dta" 


set scheme cleanplots, permanently


sort team_id date

gen initial_members=team_member if date==tm(2016m1)
replace initial_members=team_member if team_id!=team_id[_n-1]
replace initial_members=initial_members[_n-1] if team_id==team_id[_n-1]


****drop 2016

cd "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\robustness checks\excluding years"

*young staff
preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==5 | job_description_code==19
keep if birth>1986
drop if year<2018
drop if treatment_team_mate==0

tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0

xtreg log_minutes D_7-D_2 x D0-D7 i.date age days_ab, fe cluster(CDMATR) level(95) robust


coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(medium)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.1(0.05)0.1) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Exclude Years - Young Nurses", size(large)) saving(young_nurses.gph, replace)
restore



*young doctors

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==15
keep if birth>1978
keep if initial_members>3
drop if year<2018
drop if treatment_team_mate==0

tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0

xtreg log_minutes D_7-D_2 x D0-D7 i.date days_ab, fe cluster(CDMATR) level(95) robust


coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(medium)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.1(0.05)0.1) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Exclude Years - Young Doctors", size(large)) saving(young_doctors.gph, replace)
restore

*old staff

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==5 | job_description_code==19
keep if birth<1986
drop if year<2018
drop if treatment_team_mate==0

tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0

xtreg log_minutes D_7-D_2 x D0-D7 i.date age days_ab, fe cluster(CDMATR) level(95) robust


coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(medium)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.1(0.05)0.1) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Exclude Years - Old Nurses", size(large)) saving(old_nurses.gph, replace)
restore

*old doctors

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==15
keep if birth<1978
keep if initial_members>3
drop if year<2018
drop if treatment_team_mate==0

tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0

xtreg log_minutes D_7-D_2 x D0-D7 i.date days_ab, fe cluster(CDMATR) level(95) robust


coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(medium)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.1(0.05)0.1) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Exclude Years - Old Doctors", size(large)) saving(old_doctors.gph, replace)
restore




gr combine young_nurses.gph young_doctors.gph old_nurses.gph old_doctors.gph, ycommon
graph export "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\robustness checks\excluding years\Excluding years.png", as(png) name("Graph") replace



****levels


cd "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\robustness checks\levels"

*young staff
preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==5 | job_description_code==19
keep if birth>1986
drop if treatment_team_mate==0

tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen x=0

xtreg tot_minutes D_7-D_2 x D0-D7 i.date age days_ab, fe cluster(CDMATR) level(95) robust


coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(medium)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-500(100)500) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Young Staff, Minutes Worked", size(large)) saving(levels_young_staff_hours.gph, replace)
restore


*young doctors

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==15
keep if birth>1978

drop if treatment_team_mate==0

tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen x=0

xtreg tot_minutes D_7-D_2 x D0-D7 i.date age days_ab, fe cluster(CDMATR) level(95) robust


coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(medium)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-500(100)500) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Young Doctors, Minutes Worked", size(large)) saving(levels_young_doctors_hours.gph, replace)
restore


*old staff

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==5 | job_description_code==19
keep if birth<1986
drop if treatment_team_mate==0

tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen x=0

xtreg tot_minutes D_7-D_2 x D0-D7 i.date age days_ab, fe cluster(CDMATR) level(95) robust


coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(medium)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-500(100)500) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Old Staff, Minutes Worked", size(large)) saving(levels_old_staff_hours.gph, replace)
restore


*old doctors

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==15
keep if birth<1978

drop if treatment_team_mate==0

tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen x=0

xtreg tot_minutes D_7-D_2 x D0-D7 i.date age days_ab, fe cluster(CDMATR) level(95) robust


coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(medium)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-500(100)500) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Old Doctors, Minutes Worked", size(large)) saving(levels_old_doctors_hours.gph, replace)
restore



gr combine levels_young_staff_hours.gph levels_young_doctors_hours.gph levels_old_staff_hours.gph levels_old_doctors_hours.gph, ycommon
graph export "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\robustness checks\levels\Minutes worked Levels.png", as(png) name("Graph") replace






******event study only treated 

cd "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\robustness checks\no never treated"



*young staff

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==5 | job_description_code==19
keep if birth>1986
drop if treatment_team_mate==0


tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0


xtreg log_minutes D_7-D_2 x D0-D7 i.date days_ab, fe cluster(CDMATR) level(95) robust

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(medium)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.1(0.05)0.1) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Young Nurses - No Never Treated", size(large)) saving(spillover_effect_event_study_young_routine_levels_never_treated.gph, replace)
restore



*young doctors

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==15
keep if birth>1978
drop if treatment_team_mate==0


tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0

xtreg log_minutes D_7-D_2 x D0-D7 i.date days_ab, fe cluster(CDMATR) level(95) robust

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(medium)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.1(0.05)0.1) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Young Doctors - No Never Treated", size(large)) saving(spillover_effect_event_study_young_specilized_levels_never_treated.gph, replace)
restore


*old staff

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==5 | job_description_code==19
keep if birth<1986
drop if treatment_team_mate==0



tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0


xtreg log_minutes D_7-D_2 x D0-D7 i.date days_ab, fe cluster(CDMATR) level(95) robust

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(medium)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.1(0.05)0.1) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Old Nurses - No Never Treated", size(large)) saving(spillover_effect_event_study_old_routine_levels_never_treated.gph, replace)
restore



*young doctors

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==15
keep if birth<1978
drop if treatment_team_mate==0


tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0

xtreg log_minutes D_7-D_2 x D0-D7 i.date days_ab, fe cluster(CDMATR) level(95) robust

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(medium)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.1(0.05)0.1) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Old Doctors - No Never Treated", size(large)) saving(spillover_effect_event_study_old_specilized_levels_never_treated.gph, replace)
restore

gr combine spillover_effect_event_study_young_routine_levels_never_treated.gph spillover_effect_event_study_young_specilized_levels_never_treated.gph spillover_effect_event_study_old_routine_levels_never_treated.gph spillover_effect_event_study_old_specilized_levels_never_treated.gph, ycommon
graph export "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\robustness checks\no never treated\No Never Treated.png", as(png) name("Graph") replace







********change the age definitions

cd "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\robustness checks\age changed"

*young staff

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==5 | job_description_code==19
keep if birth>1984


tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0


xtreg log_minutes D_7-D_2 x D0-D7 i.date days_ab, fe cluster(CDMATR) level(95) robust

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(medium)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.1(0.05)0.1) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Changed Age Limits - Young Nurses", size(large)) saving(changed_age_young_nurses.gph, replace)
restore



*young doctors

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==15
keep if birth>1976

tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0

xtreg log_minutes D_7-D_2 x D0-D7 i.date days_ab, fe cluster(CDMATR) level(95) robust

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(medium)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.1(0.05)0.1) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Changed Age Limits - Young Doctors", size(large))  saving(changed_age_young_doctors.gph, replace) 
restore


*old staff

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==5 | job_description_code==19
keep if birth<1984


tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0


xtreg log_minutes D_7-D_2 x D0-D7 i.date days_ab, fe cluster(CDMATR) level(95) robust

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(medium)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.1(0.05)0.1) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Changed Age Limits - Old Nurses", size(large))  saving(changed_age_old_nurses.gph, replace)
restore



*old doctors

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==15
keep if birth<1978

tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0

xtreg log_minutes D_7-D_2 x D0-D7 i.date days_ab, fe cluster(CDMATR) level(95) robust

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Percentage change of minutes", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(medium)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.1(0.05)0.1) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Changed Age Limits - Old Doctors", size(large))  saving(changed_age_old_doctors.gph, replace)
restore




gr combine changed_age_young_nurses.gph changed_age_young_doctors.gph changed_age_old_nurses.gph changed_age_old_doctors.gph, ycommon
graph export "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\robustness checks\age changed\Age Changed Two Years.png", as(png) name("Graph") replace




*absences after health shocks




cd "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\robustness checks\sick days"




*staff

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==5 | job_description_code==19


tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0


xtreg days_ab D_7-D_2 x D0-D7 i.date, fe cluster(CDMATR) level(95) robust

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Absences", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(medium)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.5(0.1)0.5) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Absences - Nurses", size(large))  saving(absences_nurses.gph, replace)
restore



*doctors

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==15

tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0

xtreg days_ab D_7-D_2 x D0-D7 i.date, fe cluster(CDMATR) level(95) robust

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Absences", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(medium)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-0.5(0.1)0.5) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Absences - Doctors", size(large))  saving(absences_doctors.gph, replace)
restore




gr combine absences_nurses.gph absences_doctors.gph, ycommon
graph export "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\robustness checks\sick days\absences.png", as(png) name("Graph") replace




****change size threshold


