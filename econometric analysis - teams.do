clear
use "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\final dataset and analysis\dataset final - hospital data.dta" 

replace treatment_team_mate=team_mate_shock

drop team_id
egen team_id=concat(job_id job_location_code job_level_new)
bysort team_id date: egen age_team=mean(age)
gen women=1 if gender=="F"
replace women=0 if women==.
bysort team_id date: egen women_team=mean(women) 

*gen experience variable for individuals and teams
bysort CDMATR date: egen experience=mean(hiring_year)
replace experience=year-hiring_year
replace experience=0 if experience<0
bysort team_id date: egen team_experience=mean(experience)

*gen average absences

bysort team_id date: egen absences_team=mean(days_ab)  if treatment_health_shock==0


*drop treated individuals

sort team_id date
drop if team_id==team_id[_n-1] & date==date[_n-1]

keep team_id team_mate_shock team_member date job_description_code age_team women_team team_experience absences_team 
replace team_mate_shock=0 if team_mate_shock!=12


*doctors
*keep if job_description_code==15


encode team_id, gen(x)
rename x team_id_encode

xtset team_id_encode date

sort team_id date
replace team_mate_shock=13 if team_mate_shock[_n-1]==12 & team_id==team_id[_n-1] & team_mate_shock==0
replace team_mate_shock=11 if team_mate_shock[_n+1]==12 & team_id==team_id[_n+1] & team_mate_shock==0
replace team_mate_shock=14 if team_mate_shock[_n-1]==13 & team_id==team_id[_n-1] & team_mate_shock==0
replace team_mate_shock=10 if team_mate_shock[_n+1]==11 & team_id==team_id[_n+1] & team_mate_shock==0
replace team_mate_shock=15 if team_mate_shock[_n-1]==14 & team_id==team_id[_n-1] & team_mate_shock==0
replace team_mate_shock=9 if team_mate_shock[_n+1]==10 & team_id==team_id[_n+1] & team_mate_shock==0
replace team_mate_shock=16 if team_mate_shock[_n-1]==15 & team_id==team_id[_n-1] & team_mate_shock==0
replace team_mate_shock=8 if team_mate_shock[_n+1]==9 & team_id==team_id[_n+1] & team_mate_shock==0
replace team_mate_shock=17 if team_mate_shock[_n-1]==16 & team_id==team_id[_n-1] & team_mate_shock==0
replace team_mate_shock=7 if team_mate_shock[_n+1]==8 & team_id==team_id[_n+1] & team_mate_shock==0
replace team_mate_shock=18 if team_mate_shock[_n-1]==17 & team_id==team_id[_n-1] & team_mate_shock==0
replace team_mate_shock=6 if team_mate_shock[_n+1]==7 & team_id==team_id[_n+1] & team_mate_shock==0

bysort team_id: egen mean_members=mean(team_member)


*team members

*full sample of staff by team structure

preserve
keep if job_description_code==5 | job_description_code==19
replace team_mate_shock=team_mate_shock-12

lgraph team_member team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members<8, errortype(ci(95))
restore

preserve
keep if job_description_code==5 | job_description_code==19
replace team_mate_shock=team_mate_shock-12

lgraph team_member team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members>7 & mean_members<15, errortype(ci(95))
restore

preserve
keep if job_description_code==5 | job_description_code==19
replace team_mate_shock=team_mate_shock-12

lgraph team_member team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members>14 & mean_members<30, errortype(ci(95))
restore

preserve
keep if job_description_code==5 | job_description_code==19
replace team_mate_shock=team_mate_shock-12

lgraph team_member team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members>29 & mean_members<50, errortype(ci(95))
restore

preserve
keep if job_description_code==5 | job_description_code==19
replace team_mate_shock=team_mate_shock-12

lgraph team_member team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members>49 & mean_members<75, errortype(ci(95))
restore

*full sample of doctors by team structure


preserve
keep if job_description_code==15
replace team_mate_shock=team_mate_shock-12

lgraph team_member team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members<10, errortype(ci(95))
restore


preserve
keep if job_description_code==15
replace team_mate_shock=team_mate_shock-12

lgraph team_member team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members>9 & mean_members<20, errortype(ci(95))
restore

*age of the team staff

preserve
keep if job_description_code==5 | job_description_code==19
replace team_mate_shock=team_mate_shock-12
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0

lgraph age_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members<15, errortype(ci(95))
restore


preserve
keep if job_description_code==5 | job_description_code==19
replace team_mate_shock=team_mate_shock-12
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0

lgraph age_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members>14 & mean_members<75, errortype(ci(95))
restore

*age of team doctors 

preserve
keep if job_description_code==15
replace team_mate_shock=team_mate_shock-12
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0


lgraph age_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members<10, errortype(ci(95))
restore

preserve
keep if job_description_code==15
replace team_mate_shock=team_mate_shock-12
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0


lgraph age_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members>9 & mean_members<20, errortype(ci(95))
restore

*gender composition of staff

preserve
keep if job_description_code==5 | job_description_code==19
replace team_mate_shock=team_mate_shock-12 
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0


lgraph women_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members<15, errortype(ci(95))
restore


preserve
keep if job_description_code==5 | job_description_code==19
replace team_mate_shock=team_mate_shock-12
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0


lgraph women_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members>14 & mean_members<75, errortype(ci(95))
restore

*gender composition of doctors

preserve
keep if job_description_code==15
replace team_mate_shock=team_mate_shock-12
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0


lgraph women_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members<10, errortype(ci(95))
restore


preserve
keep if job_description_code==15
replace team_mate_shock=team_mate_shock-12
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0

lgraph women_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members>9 & mean_members<20, errortype(ci(95))
restore

*absences over time doctors staff
 

preserve
keep if job_description_code==5 | job_description_code==19
replace team_mate_shock=team_mate_shock-12 
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0


lgraph women_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members<15, errortype(ci(95))
restore


preserve
keep if job_description_code==5 | job_description_code==19
replace team_mate_shock=team_mate_shock-12
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0


lgraph women_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members>14 & mean_members<75, errortype(ci(95))
restore

*absences over time doctors

preserve
keep if job_description_code==15
replace team_mate_shock=team_mate_shock-12
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0


lgraph women_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members<10, errortype(ci(95))
restore


preserve
keep if job_description_code==15
replace team_mate_shock=team_mate_shock-12
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0

lgraph women_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members>9 & mean_members<20, errortype(ci(95))
restore

*comparison groups, treatment vs control 


preserve
gen treat_group=1 if team_mate_shock>0
sort team_id treat_group
replace treat_group=treat_group[_n-1] if _n!=1 & team_id==team_id[_n-1]
replace treat_group=0 if treat_group==.
sort team_id date
drop if team_id==team_id[_n-1]

*full sample

ttest women_team if job_description_code==15 | job_description_code==5 | job_description_code==19, by(treat_group)

ttest age_team if job_description_code==15 | job_description_code==5 | job_description_code==19, by(treat_group)

ttest team_experience if job_description_code==15 | job_description_code==5 | job_description_code==19, by(treat_group)

ttest absences_team if job_description_code==15 | job_description_code==5 | job_description_code==19, by(treat_group)

*doctors

ttest women_team if job_description_code==15, by(treat_group)

ttest age_team if job_description_code==15, by(treat_group)

ttest team_experience if job_description_code==15, by(treat_group)

ttest absences_team if job_description_code==15, by(treat_group) 

*staff

ttest women_team if job_description_code==5 | job_description_code==19, by(treat_group)

ttest age_team if job_description_code==5 | job_description_code==19, by(treat_group)

ttest team_experience if job_description_code==5 | job_description_code==19, by(treat_group)

ttest absences_team if job_description_code==5 | job_description_code==19, by(treat_group)

restore