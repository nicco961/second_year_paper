clear
use "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\final dataset\dataset final - hospital data.dta" 


   
   
   
   /*-------------------------------------------------------
---------------------------------------------------------
+++++++++++++++ DIFF IN DIFF ++++++++++++++++++++++++++++
---------------------------------------------------------
---------------------------------------------------------
*/

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

replace D1=D1+D2+D3+D4+D5+D6


xtreg log_minutes D_7-D_2 x D0 D1 D7 i.date days_ab, fe cluster(CDMATR) level(95) robust
estimates store staff_old, title(Old Staff)

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

gen log_minutes=log(tot_minutes)

gen x=0

replace D1=D1+D2+D3+D4+D5+D6


xtreg log_minutes D_7-D_2 x D0 D1 D7 i.date days_ab, fe cluster(CDMATR) level(95) robust

estimates store doctors_old, title(Old Doctors)

restore


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

replace D1=D1+D2+D3+D4+D5+D6


xtreg log_minutes D_7-D_2 x D0 D1 D7 i.date days_ab, fe cluster(CDMATR) level(95) robust
estimates store staff_Young, title(Young Staff)

restore




*young doctors

preserve
drop if treatment_health_shock==1

sort CDMATR date

tab team_mate_shock
keep if job_description_code==15
keep if birth>1977
drop if treatment_team_mate==0



tab team_mate_shock treatment_team_mate
tab treatment_team_mate

egen team_id_new=concat(location_code_1 location_code_2 location_code_3 job_level_new)
drop team_id
encode team_id_new, gen(team_id)

gen log_minutes=log(tot_minutes)

gen x=0

replace D1=D1+D2+D3+D4+D5+D6


xtreg log_minutes D_7-D_2 x D0 D1 D7 i.date days_ab, fe cluster(CDMATR) level(95) robust

estimates store doctors_young, title(Young Doctors)

restore




cd "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\tables"


esttab staff_old doctors_old staff_Young staff_old using diff_in_diff_individuals_health_shock.tex , cells(b(star fmt(3)) se(par fmt(2))) keep(D0 D1) legend label varlabels(_cons Constant) replace


   
   
   
   
