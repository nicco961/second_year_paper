clear
use "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\final dataset\dataset final - hospital data - team observation.dta"

set scheme cleanplots, permanently

*team size percentiles

preserve
keep if job_description_code==5 | job_description_code==19
pctile pct=team_member, nq(20)
list pct in 1/20
restore

preserve
keep if job_description_code==15
pctile pct=team_member, nq(20)
lis pct in 1/20
restore

*team member by job_description_code

*team members

*full sample of staff by team structure
/*
preserve
keep if job_description_code==5 | job_description_code==19
replace team_mate_shock=team_mate_shock-12

lgraph team_member team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members<15, ytitle("Team size") xtitle("Time to co-worker shock", yoffset(-2)) scale(0.6) plotregion(fcolor(white)) yscale(r(5(1)10)) ylabel(5(1)10) xscale(r(-6(1)6)) xlabel(-6(1)6) 
restore

preserve
keep if job_description_code==5 | job_description_code==19
replace team_mate_shock=team_mate_shock-12

lgraph team_member team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members>15 & mean_members<30, ytitle("Team size") xtitle("Time to co-worker shock", yoffset(-2)) scale(0.6) plotregion(fcolor(white)) yscale(r(5(1)10)) ylabel(5(1)10) xscale(r(-6(1)6)) xlabel(-6(1)6) 
restore

preserve
keep if job_description_code==5 | job_description_code==19
replace team_mate_shock=team_mate_shock-12

lgraph team_member team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members>29 & mean_members<50, ytitle("Team size") xtitle("Time to co-worker shock", yoffset(-2)) scale(0.6) plotregion(fcolor(white)) yscale(r(5(1)10)) ylabel(5(1)10) xscale(r(-6(1)6)) xlabel(-6(1)6) 
restore

preserve
keep if job_description_code==5 | job_description_code==19
replace team_mate_shock=team_mate_shock-12

lgraph team_member team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members>49 & mean_members<75, ytitle("Team size") xtitle("Time to co-worker shock", yoffset(-2)) scale(0.6) plotregion(fcolor(white)) yscale(r(5(1)10)) ylabel(5(1)10) xscale(r(-6(1)6)) xlabel(-6(1)6) 
restore

*full sample of doctors by team structure


preserve
keep if job_description_code==15
replace team_mate_shock=team_mate_shock-12

lgraph team_member team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members<10, errortype(ci(95)) title("Percentage change of minutes") xtitle("Time to co-worker shock", yoffset(-2)) scale(0.8) plotregion(fcolor(white))
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

lgraph age_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members<15, errortype(ci(95)) ytitle("Team average age") xtitle("Time to co-worker shock", yoffset(-2)) scale(0.6) plotregion(fcolor(white)) yscale(r(50(1)54)) ylabel(50(1)54) xscale(r(-6(1)6)) xlabel(-6(1)6) 
restore


preserve
keep if job_description_code==5 | job_description_code==19
replace team_mate_shock=team_mate_shock-12
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0

lgraph age_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members>14 & mean_members<75, errortype(ci(95)) ytitle("Team average age") xtitle("Time to co-worker shock", yoffset(-2)) scale(0.6) plotregion(fcolor(white)) yscale(r(44(1)50)) ylabel(44(1)50) xscale(r(-6(1)6)) xlabel(-6(1)6) 
restore

*age of team doctors 

preserve
keep if job_description_code==15
replace team_mate_shock=team_mate_shock-12
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0


lgraph age_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members<11, errortype(ci(95)) ytitle("Team average age") xtitle("Time to co-worker shock", yoffset(-2)) scale(0.6) plotregion(fcolor(white)) yscale(r(49(1)57)) ylabel(49(1)57) xscale(r(-6(1)6)) xlabel(-6(1)6) 
restore

preserve
keep if job_description_code==15
replace team_mate_shock=team_mate_shock-12
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0


lgraph age_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members>10 & mean_members<20, errortype(ci(95)) ytitle("Team average age") xtitle("Time to co-worker shock", yoffset(-2)) scale(0.6) plotregion(fcolor(white)) yscale(r(49(1)54)) ylabel(49(1)54) xscale(r(-6(1)6)) xlabel(-6(1)6) 
restore

*gender composition of staff

preserve
keep if job_description_code==5 | job_description_code==19
replace team_mate_shock=team_mate_shock-12 
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0


lgraph women_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members<15, errortype(ci(95)) ytitle("Share of women in team") xtitle("Time to co-worker shock", yoffset(-2)) scale(0.6) plotregion(fcolor(white)) yscale(r(0.7(0.05)1)) ylabel(0.7(0.05)1) xscale(r(-6(1)6)) xlabel(-6(1)6) 
restore


preserve
keep if job_description_code==5 | job_description_code==19
replace team_mate_shock=team_mate_shock-12
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0


lgraph women_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members>14 & mean_members<75, errortype(ci(95)) ytitle("Share of women in team") xtitle("Time to co-worker shock", yoffset(-2)) scale(0.6) plotregion(fcolor(white)) yscale(r(0.7(0.05)0.9)) ylabel(0.7(0.05)0.9) xscale(r(-6(1)6)) xlabel(-6(1)6) 
restore

*gender composition of doctors

preserve
keep if job_description_code==15
replace team_mate_shock=team_mate_shock-12
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0


lgraph women_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members<11, errortype(ci(95)) ytitle("Share of women in team") xtitle("Time to co-worker shock", yoffset(-2)) scale(0.6) plotregion(fcolor(white)) yscale(r(0.2(0.05)0.6)) ylabel(0.2(0.05)0.6) xscale(r(-6(1)6)) xlabel(-6(1)6) 
restore


preserve
keep if job_description_code==15
replace team_mate_shock=team_mate_shock-12
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0

lgraph women_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members>10 & mean_members<20, errortype(ci(95)) ytitle("Share of women in team") xtitle("Time to co-worker shock", yoffset(-2)) scale(0.6) plotregion(fcolor(white)) yscale(r(0.25(0.05)0.75)) ylabel(0.25(0.05)0.75) xscale(r(-6(1)6)) xlabel(-6(1)6) 
restore

*tenure over time staff
 

preserve
keep if job_description_code==5 | job_description_code==19
replace team_mate_shock=team_mate_shock-12 
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0


lgraph team_experience team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members<15, errortype(ci(95)) ytitle("Average absences") xtitle("Time to co-worker shock", yoffset(-2)) scale(0.6) plotregion(fcolor(white)) yscale(r(0(0.5)3)) ylabel(0(0.5)3) xscale(r(-6(1)6)) xlabel(-6(1)6) 
restore


preserve
keep if job_description_code==5 | job_description_code==19
replace team_mate_shock=team_mate_shock-12
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0


lgraph team_experience team_mate_shock if team_mate_shock>-7 & team_mate_shock<7 & mean_members>14 & mean_members<75, errortype(ci(95)) ytitle("Average absences") xtitle("Time to co-worker shock", yoffset(-2)) scale(0.6) plotregion(fcolor(white)) yscale(r(0.5(0.1)1)) ylabel(0.5(0.1)1) xscale(r(-6(1)6)) xlabel(-6(1)6) 
restore

*absences over time doctors

preserve
keep if job_description_code==15
replace team_mate_shock=team_mate_shock-12
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0


lgraph absences_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7, errortype(ci(95)) ytitle("Average absences") xtitle("Time to co-worker shock", yoffset(-2)) scale(0.6) plotregion(fcolor(white)) yscale(r(0(0.25)1)) ylabel(0(0.25)1) xscale(r(-6(1)6)) xlabel(-6(1)6) 
restore


preserve
keep if job_description_code==5 | job_description_code==19
replace team_mate_shock=team_mate_shock-12
drop if team_mate_shock==0 & team_mate_shock[_n-1]==0

lgraph absences_team team_mate_shock if team_mate_shock>-7 & team_mate_shock<7, errortype(ci(95)) ytitle("Average absences") xtitle("Time to co-worker shock", yoffset(-2)) scale(0.6) plotregion(fcolor(white)) yscale(r(0.5(0.25)1.5)) ylabel(0.5(0.25)1.5) xscale(r(-6(1)6)) xlabel(-6(1)6) 
restore
*/

*++++++++++++++++++++
*++++++++++++++++++++
*++++++++++++++++++++

cd "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\do file analysis\tables\summary stats teams"

bysort team_id: ereplace absences_team = mean(absences_team)


*summary stats

preserve
gen treat_group=1 if team_mate_shock>0
sort team_id treat_group
replace treat_group=treat_group[_n-1] if _n!=1 & team_id==team_id[_n-1]
replace treat_group=0 if treat_group==.
sort team_id date
drop if team_id==team_id[_n-1]
drop if team_member < 3

gen doctor = 1 if job_description_code == 15
replace doctor = 0 if doctor == .

eststo doctors: quietly estpost summarize women_team age_team team_experience team_member treat_group if job_description_code==15

eststo nurses: quietly estpost summarize women_team age_team team_experience team_member treat_group if job_description_code==5 | job_description_code==19


*GENERATE TABLE	
esttab doctors nurses using summary_stats_teams.tex , cells("mean(pattern(1 1 0) fmt(2)) sd(pattern(1 1 0)) b(star pattern(0 0 1) fmt(2)) p(pattern(0 0 1) par fmt(2))") label replace
restore


*comparison groups, treatment vs control 


*full sample

preserve
gen treat_group=1 if team_mate_shock>0
sort team_id treat_group
replace treat_group=treat_group[_n-1] if _n!=1 & team_id==team_id[_n-1]
replace treat_group=0 if treat_group==.
sort team_id date
drop if team_id==team_id[_n-1]
drop if team_member < 3


eststo control: quietly estpost summarize women_team age_team team_experience absences_team if treat_group==0 & job_description_code==15 | treat_group==0 & job_description_code==5 | treat_group==0 & job_description_code==19

eststo treatment: quietly estpost summarize women_team age_team team_experience absences_team if treat_group==1 & job_description_code==15 | treat_group==1 & job_description_code==5 | treat_group==1 & job_description_code==19

eststo diff:  estpost ttest women_team age_team team_experience absences_team if job_description_code==15 | job_description_code==5 | job_description_code==19, by(treat_group)	


*GENERATE TABLE	
esttab control treatment diff using sumtable1_1.tex , cells("mean(pattern(1 1 0) fmt(2)) sd(pattern(1 1 0)) b(star pattern(0 0 1) fmt(2)) p(pattern(0 0 1) par fmt(2))") label replace

*doctors


eststo control: quietly estpost summarize women_team age_team team_experience absences_team if treat_group==0 & job_description_code==15

eststo treatment: quietly estpost summarize women_team age_team team_experience absences_team if treat_group==1 & job_description_code==15 

eststo diff: quietly estpost ttest women_team age_team team_experience absences_team if job_description_code==15, by(treat_group)	

*GENERATE TABLE	
esttab control treatment diff using sumtable1_2.tex , cells("mean(pattern(1 1 0) fmt(2)) sd(pattern(1 1 0)) b(star pattern(0 0 1) fmt(2)) p(pattern(0 0 1) par fmt(2))") label replace

*staff


eststo control: quietly estpost summarize women_team age_team team_experience absences_team if treat_group==0 & job_description_code==5 | treat_group==0 & job_description_code==19

eststo treatment: quietly estpost summarize women_team age_team team_experience absences_team if treat_group==1 & job_description_code==5 | treat_group==1 & job_description_code==19

eststo diff: quietly estpost ttest women_team age_team team_experience absences_team if job_description_code==5 | job_description_code==19, by(treat_group)	

*GENERATE TABLE	
esttab control treatment diff using sumtable1_3.tex , cells("mean(pattern(1 1 0) fmt(2)) sd(pattern(1 1 0)) b(star pattern(0 0 1) fmt(2)) p(pattern(0 0 1) par fmt(2))") label replace
	
restore



gen treat_group=1 if team_mate_shock>0
sort team_id treat_group
replace treat_group=treat_group[_n-1] if _n!=1 & team_id==team_id[_n-1]
replace treat_group=0 if treat_group==.
sort team_id date
drop if team_member < 3
keep if job_description_code == 5 | job_description_code == 15 | job_description_code == 19

keep if team_id != ""

keep if team_mate_shock == 12
drop if team_id == team_id[_n-1] & date == date[_n-1] + 1

gen x = 1

replace job_description_code = 5 if job_description_code == 19
collapse (sum) x, by(job_description_code)

