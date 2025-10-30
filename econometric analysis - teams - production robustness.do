clear
use "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\final dataset\dataset final - hospital data - team production.dta"

cd "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\tables\production" 

set scheme cleanplots, permanently

destring team_id, gen(team_id_num)

*team id with 1xxx doctors, with 2xxx nurses, 3xxx other staff

*log production

gen log_clinic=log(tot_clinic+1)
gen log_hospital=log(tot_hospital+1)

*treat NA

replace tot_clinic=0 if tot_clinic==.
replace tot_hospital=0 if tot_hospital==.



*correlations production/absences

preserve
drop if mean_members<3

reg log_clinic absences_team i.team_id_encode i.date
estimates store production_clinic, title(Ambulatory)

reg log_hospital absences_team i.team_id_encode i.date
estimates store production_hospital, title(Hospitalizations)

restore

*higher than 85th percentile

drop if date > tm(2019m12)

pctile pct = absences_team , nq(20)

list pct in 1/20

*absences here are considered only the ones during health shocks


gen x=0
drop if mean_members<3
codebook team_id

replace log_clinic=log(tot_clinic+1)
replace log_hospital=log(tot_hospital+1)


cd "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\figures\production"

*doctors all teams


preserve

keep if team_id_num<1999 & team_id_num>999


reg log_hospital absences_team i.team_id_encode i.date
estimates store production_hospital_doctors, title(Hospital Doctors Absences)

reg log_clinic absences_team i.team_id_encode i.date
estimates store production_clinic_doctors, title(Clinic Doctors Absences)

restore





*nurses and staff all teams

 

preserve

keep if team_id_num>1999


reg log_hospital absences_team i.team_id_encode i.date
estimate store production_hospital_nurses

reg log_clinic absences_team i.team_id_encode i.date
estimate store production_clinic_nurses

restore




cd "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\tables\production robustness" 

***combine regression results

esttab production_hospital_doctors production_clinic_doctors production_hospital_nurses production_clinic_nurses using production_no_covid.tex, replace cells(b(star fmt(3)) se(par fmt(2))) keep(absences_team) ///
   legend label varlabels(_cons Constant)





