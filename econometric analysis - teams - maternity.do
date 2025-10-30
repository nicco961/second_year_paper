clear
use "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\final dataset\dataset final - hospital data - team observation.dta"


cd "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\robustness checks\maternity leaves"

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

tab maternity_shock


*create all event study dummy


gen M_6=1 if maternity_shock==4
replace M_6=0 if M_6==.

gen M_5=1 if maternity_shock==5
replace M_5=0 if M_5==.

gen M_4=1 if maternity_shock==6
replace M_4=0 if M_4==.

gen M_3=1 if maternity_shock==7
replace M_3=0 if M_3==.

gen M_2=1 if maternity_shock==8
replace M_2=0 if M_2==.

gen M_1=1 if maternity_shock==9
replace M_1=0 if M_1==.

gen M0=1 if maternity_shock==10
replace M0=0 if M0==.

gen M1=1 if maternity_shock==11
replace M1=0 if M1==.

gen M2=1 if maternity_shock==12
replace M2=0 if M2==.

gen M3=1 if maternity_shock==13
replace M3=0 if M3==.

gen M4=1 if maternity_shock==14
replace M4=0 if M4==.

gen M5=1 if maternity_shock==15
replace M5=0 if M5==.

gen M6=1 if maternity_shock==16
replace M6=0 if M6==.

gen M7=1 if maternity_shock==17
replace M7=0 if M7==.

replace maternity_shock=3 if treatment_maternity==1 & maternity_shock==0

gen M_7=1 if maternity_shock==3
replace M_7=0 if M_7==.

*teams staff

preserve

keep if job_description_code==5 | job_description_code==19
gen x=0

xtreg team_member M_7 M_6-M_2 x M0-M6 M7 i.date, fe cluster(team_id_encode) level(95) robust

coefplot, vertical keep(M_6 M_5 M_4 M_3 M_2 x M0 M1 M2 M3 M4 M5 M6) yline(0) levels(95) coeflabels(M_6="-6"  M_5="-5" M_4="-4" M_3="-3" M_2 ="-2" x="-1" M0="0" M1="1" M2="2" M3="3" M4="4" M5="5" M6="6")  ytitle("Change of Members", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(medium)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-3(1)3) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Team Nurses - Maternities", size(large)) saving(maternity_nurses, replace)
graph export teams_routine_maternity.png, replace
restore

*team doctors

preserve

keep if job_description_code==15

gen x=0

xtreg team_member M_7 M_6-M_2 x M0-M6 M7 i.treatment_maternity i.date, fe cluster(team_id_encode) level(95) robust

coefplot, vertical keep(M_6 M_5 M_4 M_3 M_2 x M0 M1 M2 M3 M4 M5 M6) yline(0) levels(95) coeflabels(M_6="-6"  M_5="-5" M_4="-4" M_3="-3" M_2 ="-2" x="-1" M0="0" M1="1" M2="2" M3="3" M4="4" M5="5" M6="6")  ytitle("Change of Members", size(large)) xtitle("Time to co-worker shock", yoffset(-2) size(medium)) recast(noconnected) omitted yscale(r(-0.1 0.1) lc(black)) ylabel(-3(1)3) xscale(lc(black)) scale(0.8)  xline(6, lcolor(black) lwidth(medium))  ciopts(recast(rcap) lc(black) fcolor(white)) yline(0, lcolor(black)) plotregion(fcolor(white)) title("Team Doctors - Maternities", size(large)) saving(maternity_doctors, replace)
graph export teams_specialized_maternity.png, replace
restore


gr combine maternity_nurses.gph maternity_doctors.gph, ycommon
graph export "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\robustness checks\maternity leaves\maternity.png", as(png) name("Graph") replace


