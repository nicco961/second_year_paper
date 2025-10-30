clear
use "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\final dataset\dataset final - hospital data.dta" 

cd "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\tables\summary stats individuals"

set scheme cleanplots, permanently

*now, not yet treated as control units (5 april 2023)

*use initial size


sort team_id date
gen initial_members=team_member if date==tm(2016m1)
replace initial_members=team_member if team_id!=team_id[_n-1]
replace initial_members=initial_members[_n-1] if team_id==team_id[_n-1]

*individuals

gen city_resident=1 if city_residence=="FIRENZE"
replace city_resident=0 if city_resident==.

keep if job_description_code==5 | job_description_code==15 | job_description_code==19
tab location_code_3 if job_description_code==5 | job_description_code==19
tab location_code_3 if job_description_code==15

preserve

sort CDMATR
by CDMATR: ereplace days_absence = mean(days_absence)
by CDMATR: ereplace tot_minutes = mean(tot_minutes)

sort CDMATR date
drop if CDMATR==CDMATR[_n-1]
drop if CDMATR==.
drop if team_member < 3

gen women=1 if gender=="F"
replace women=0 if women==.

codebook location_code_2

gen doctor = 1 if job_description_code == 15
replace doctor = 0 if doctor == .

gen age_at_2022 = 2022-birth

eststo doctors: estpost summarize age_at_2022 women tot_minutes days_absence city_resident treatment_health_shock if job_description_code==15

eststo staff: estpost summarize age_at_2022 women tot_minutes days_absence city_resident treatment_health_shock if job_description_code==5 | job_description_code==19



restore


*GENERATE TABLE	
esttab doctors staff using sumtable_individuals.tex , cells("mean(pattern(1 1 0) fmt(2)) sd(pattern(1 1 0)) b(star pattern(0 0 1) fmt(2)) p(pattern(0 0 1) par fmt(2))") label replace



*histograms

histogram tot_minutes if job_description_code==15, bin(75) xtitle("Minutes Worked") scale(0.8) color(black) fcolor(red)  saving(histogram_doctors_minutes.gph, replace)
histogram tot_minutes if job_description_code==5 | job_description_code==19, bin(75) xtitle("Minutes Worked") scale(0.8) color(black) fcolor(red) saving(histogram_nurses_minutes.gph, replace)

gr combine histogram_doctors_minutes.gph histogram_nurses_minutes.gph, ycommon
graph export "histograms_minutes.png", as(png) name("Graph") replace



preserve

drop if simple_health_shock == 0

sort CDMATR date
replace days_absence = days_absence + days_absence[_n-1]  if simple_health_shock > 0 & CDMATR == CDMATR[_n-1]
drop if CDMATR == CDMATR[_n+1]

histogram days_absence if simple_health_shock>0, title("Lenght of Absences") xtitle("Absence Days") ytitle("") scale(0.8) color(black) fcolor(red) ylabel(0(0.01)0.05) xlabel(30(30)150) 
graph export "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\tables\summary stats individuals\histogram_absence_duration.png", as(png) name("Graph") replace
restore

histogram month if simple_health_shock>0, discrete title("Month of Absences") xtitle("Month") ytitle("") scale(0.6) color(black) fcolor(red) ylabel(0(0.05)0.2) xlabel(1(1)12)

graph export "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\tables\summary stats individuals\histogram_absence_month.png", as(png) name("Graph") replace


