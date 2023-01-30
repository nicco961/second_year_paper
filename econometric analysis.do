clear
use "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\final dataset and analysis\dataset final - hospital data.dta" 


*young staff in large teams
preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==5 | job_description_code==19
keep if birth>1986
keep if team_member<75

tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)


xtreg log_minutes i.team_mate_shock i.date i.days_ab team_member i.team_id, cluster(CDMATR) level(95)


coefplot, vertical keep(2.team_mate_shock 6.team_mate_shock 7.team_mate_shock 8.team_mate_shock 9.team_mate_shock 10.team_mate_shock 11.team_mate_shock 12.team_mate_shock 13.team_mate_shock 14.team_mate_shock 15.team_mate_shock 16.team_mate_shock 17.team_mate_shock 18.team_mate_shock 40.team_mate_shock) yline(0) levels(95) coeflabels(2.team_mate_shock="-7+" 6.team_mate_shock="-6"  7.team_mate_shock ="-5" 8.team_mate_shock ="-4" 9.team_mate_shock ="-3" 10.team_mate_shock ="-2" 11.team_mate_shock ="-1" 12.team_mate_shock ="0" 13.team_mate_shock ="1" 14.team_mate_shock ="2" 15.team_mate_shock="3" 16.team_mate_shock="4" 17.team_mate_shock="5" 18.team_mate_shock="6" 40.team_mate_shock="7+")  ytitle("Minutes") xtitle("Time to health shock") recast(connected) omitted baselevels
restore



*young staff in small teams

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==5 | job_description_code==19
keep if birth>1986
keep if team_member<16

tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

xtreg log_minutes i.team_mate_shock i.date i.days_ab team_member i.team_id, cluster(CDMATR) level(95)


coefplot, vertical keep(2.team_mate_shock 6.team_mate_shock 7.team_mate_shock 8.team_mate_shock 9.team_mate_shock 10.team_mate_shock 11.team_mate_shock 12.team_mate_shock 13.team_mate_shock 14.team_mate_shock 15.team_mate_shock 16.team_mate_shock 17.team_mate_shock 18.team_mate_shock 40.team_mate_shock) yline(0) levels(95) coeflabels(2.team_mate_shock="-7+" 6.team_mate_shock="-6"  7.team_mate_shock ="-5" 8.team_mate_shock ="-4" 9.team_mate_shock ="-3" 10.team_mate_shock ="-2" 11.team_mate_shock ="-1" 12.team_mate_shock ="0" 13.team_mate_shock ="1" 14.team_mate_shock ="2" 15.team_mate_shock="3" 16.team_mate_shock="4" 17.team_mate_shock="5" 18.team_mate_shock="6" 40.team_mate_shock="7+")  ytitle("Minutes") xtitle("Time to health shock") recast(connected) omitted baselevels
restore


*young doctors in large teams

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==15
keep if birth>1978
keep if team_member>10 & team_member<20

tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

xtreg log_minutes i.team_mate_shock i.date i.days_ab team_member i.team_id, cluster(CDMATR) level(95)

coefplot, vertical keep(2.team_mate_shock 6.team_mate_shock 7.team_mate_shock 8.team_mate_shock 9.team_mate_shock 10.team_mate_shock 11.team_mate_shock 12.team_mate_shock 13.team_mate_shock 14.team_mate_shock 15.team_mate_shock 16.team_mate_shock 17.team_mate_shock 18.team_mate_shock 40.team_mate_shock) yline(0) levels(95) coeflabels(2.team_mate_shock="-7+" 6.team_mate_shock="-6"  7.team_mate_shock ="-5" 8.team_mate_shock ="-4" 9.team_mate_shock ="-3" 10.team_mate_shock ="-2" 11.team_mate_shock ="-1" 12.team_mate_shock ="0" 13.team_mate_shock ="1" 14.team_mate_shock ="2" 15.team_mate_shock="3" 16.team_mate_shock="4" 17.team_mate_shock="5" 18.team_mate_shock="6" 40.team_mate_shock="7+")  ytitle("Minutes") xtitle("Time to health shock") recast(connected) omitted baselevels
restore

*young doctors in small teams

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==15
keep if birth>1978
keep if team_member<10

tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

xtreg log_minutes i.team_mate_shock i.date i.days_ab team_member i.team_id, cluster(CDMATR) level(95)


coefplot, vertical keep(2.team_mate_shock 6.team_mate_shock 7.team_mate_shock 8.team_mate_shock 9.team_mate_shock 10.team_mate_shock 11.team_mate_shock 12.team_mate_shock 13.team_mate_shock 14.team_mate_shock 15.team_mate_shock 16.team_mate_shock 17.team_mate_shock 18.team_mate_shock 40.team_mate_shock) yline(0) levels(95) coeflabels(2.team_mate_shock="-7+" 6.team_mate_shock="-6"  7.team_mate_shock ="-5" 8.team_mate_shock ="-4" 9.team_mate_shock ="-3" 10.team_mate_shock ="-2" 11.team_mate_shock ="-1" 12.team_mate_shock ="0" 13.team_mate_shock ="1" 14.team_mate_shock ="2" 15.team_mate_shock="3" 16.team_mate_shock="4" 17.team_mate_shock="5" 18.team_mate_shock="6" 40.team_mate_shock="7+")  ytitle("Minutes") xtitle("Time to health shock") recast(connected) omitted baselevels
restore













**normal health shocks

preserve
replace tot_hours=log(tot_hours)

xtreg tot_hours i.health_shock age i.job_level, fe cluster(CDMATR)

coefplot, vertical keep(0.health_shock 1.health_shock 2.health_shock 3.health_shock 4.health_shock 5.health_shock 6.health_shock 7.health_shock 8.health_shock 9.health_shock 10.health_shock 11.health_shock 12.health_shock) yline(0) levels(95) coeflabels(0.health_shock="-6" 1.health_shock ="-5" 2.health_shock ="-4" 3.health_shock ="-3" 4.health_shock ="-2" 5.health_shock ="-1" 6.health_shock ="0" 7.health_shock ="1" 8.health_shock ="2" 9.health_shock="3" 10.health_shock="4" 11.health_shock="5" 12.health_shock="6")  ytitle("Hours") xtitle("Time to health shock") recast(connected) omitted baselevels
restore
