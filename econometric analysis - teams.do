clear
use "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\final dataset\dataset final - hospital data - team observation.dta"


cd "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\teams health shock size"

set scheme cleanplots, permanently


gen treatment_group=1 if team_mate_shock!=0

sort team_id treatment_group 

replace treatment_group=treatment_group[_n-1] if team_id==team_id[_n-1]
replace treatment_group=0 if treatment_group==.

**Event Study variables

sort team_id date

replace team_mate_shock=19 if team_id==team_id[_n-1] & team_mate_shock[_n-1]==18

replace team_mate_shock=team_mate_shock[_n-1] if team_id==team_id[_n-1] & team_mate_shock==0

replace team_mate_shock=5 if team_mate_shock==0 & treatment_group==1

*log production

gen log_clinic=log(tot_clinic)
gen log_hospital=log(tot_hospital)

*create all event study dummy

gen D_7=1 if team_mate_shock==5
replace D_7=0 if D_7==.

gen D_6=1 if team_mate_shock==6
replace D_6=0 if D_6==.

gen D_5=1 if team_mate_shock==7
replace D_5=0 if D_5==.

gen D_4=1 if team_mate_shock==8
replace D_4=0 if D_4==.

gen D_3=1 if team_mate_shock==9
replace D_3=0 if D_3==.

gen D_2=1 if team_mate_shock==10
replace D_2=0 if D_2==.

gen D_1=1 if team_mate_shock==11
replace D_1=0 if D_1==.

gen D0=1 if team_mate_shock==12
replace D0=0 if D0==.

gen D1=1 if team_mate_shock==13
replace D1=0 if D1==.

gen D2=1 if team_mate_shock==14
replace D2=0 if D2==.

gen D3=1 if team_mate_shock==15
replace D3=0 if D3==.

gen D4=1 if team_mate_shock==16
replace D4=0 if D4==.

gen D5=1 if team_mate_shock==17
replace D5=0 if D5==.

gen D6=1 if team_mate_shock==18
replace D6=0 if D6==.

gen D7=1 if team_mate_shock==19
replace D7=0 if D7==.

*use initial size of teams

sort team_id date

gen initial_members=team_member if date==tm(2016m1)
replace initial_members=team_member if team_id!=team_id[_n-1]
replace initial_members=initial_members[_n-1] if team_id==team_id[_n-1]

preserve
keep if initial_members>2.99
codebook team_id_encode
restore


*small teams staff


preserve

keep if job_description_code==5 | job_description_code==19

keep if initial_members>0.99 & initial_members<15.01

gen x=0

sum initial_members if treatment_team_mate==1

xtreg team_member D_7-D_2 x D0-D7 i.treatment_team_mate i.date, fe cluster(team_id) level(95) robust

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Change of Members", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(large)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-2(1)2) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Small Teams of Nurses", size(large)) saving(graph_1_team, replace)
graph export team_small_staff.png, replace

restore

*small teams doctors

preserve

keep if job_description_code==15

keep if initial_members>0.99 & initial_members<10

gen x=0

*replace team_member=log(team_member)

sum initial_members if treatment_team_mate==1


xtreg team_member D_7-D_2 x D0-D7 i.treatment_team_mate i.date, fe cluster(team_id) level(95) robust


coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Change of Members", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(large)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-2(1)2) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Small Teams of Doctors", size(large)) saving(graph_2_team, replace)
graph export team_small_doctors.png, replace

restore



*large teams staff

preserve

keep if job_description_code==5 | job_description_code==19

keep if initial_members>14.99 & initial_members<75

gen x=0

*replace team_member=log(team_member)

sum initial_members if treatment_team_mate==1

xtreg team_member D_7-D_2 x D0-D7 i.treatment_team_mate i.date, fe cluster(team_id) level(95) robust


coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Change of members", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(large)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-2(1)2) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Large Teams of Nurses", size(large)) saving(graph_3_team, replace)
graph export team_large_staff.png, replace

restore


*large teams doctors

preserve

keep if job_description_code==15
keep if initial_members>10 & initial_members<20

sum initial_members if treatment_team_mate==1

gen x=0

*replace team_member=log(team_member)

xtreg team_member D_7-D_2 x D0-D7 i.treatment_team_mate i.date, fe cluster(team_id) level(95) robust

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Change of members", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(large)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-2(1)2) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Large Teams of Doctors", size(large)) saving(graph_4_team, replace)
graph export team_large_doctors.png, replace

restore

gr combine graph_3_team.gph graph_1_team.gph graph_2_team.gph graph_4_team.gph, ycommon
graph export "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\teams health shock size\table_team_event_study_size_tasks.png", as(png) name("Graph") replace




*Event Study Regressions


*staff



preserve

keep if job_description_code==5 | job_description_code==19

sum initial_members if treatment_team_mate==1

gen x=0
*replace team_member=log(team_member)

xtreg team_member D_7-D_2 x D0-D7 i.treatment_team_mate i.date, fe level(95) robust

coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Change of Members", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(large)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-2(1)2) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Teams of Nurses", size(large))  saving(graph_1_team_all_nurses, replace)

restore


*doctors

preserve

keep if job_description_code==15

sum initial_members if treatment_team_mate==1

gen x=0

*replace team_member=log(team_member)


xtreg team_member D_7-D_2 x D0-D7 i.treatment_team_mate i.date, fe level(95) robust


coefplot, vertical keep(D_6 D_5 D_4 D_3 D_2 x D0 D1 D2 D3 D4 D5 D6) yline(0) levels(95) coeflabels(D_6="-6"  D_5="-5" D_4="-4" D_3="-3" D_2 ="-2" x="-1" D0="0" D1="1" D2="2" D3="3" D4="4" D5="5" D6="6")  ytitle("Change of Members", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(large)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-2(1)2) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Teams of Doctors", size(large))  saving(graph_2_team_all_doctors, replace)

restore




gr combine graph_1_team_all_nurses.gph graph_2_team_all_doctors.gph, ycommon
graph export "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\teams health shock size\table_team_nurses_doctors_event_study.png", as(png) name("Graph") replace

