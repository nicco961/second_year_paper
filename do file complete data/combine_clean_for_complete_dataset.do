clear
*SET GLOBAL OPTIONS FOR GRAPH EXPORTING
* 
*ssc install blindschemes
*ssc install grstyle, replace
set scheme plottig, permanently
grstyle init
grstyle set size large: axis_title tick_label heading subheading
*
* help grstyle	//if needed
use "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\professional profiles.dta"

merge 1:1 CDMATR date using "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\job levels.dta"

keep if _m==1 | _m==3

drop _m

merge 1:1 CDMATR date using "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\departments.dta"
drop year

keep if _m==1 | _m==3

drop month _m

merge 1:1 CDMATR date using "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\absentees.dta"

drop if _m==2 

*when merge is 2 it's because those are not people employed regularly
*when merge is 1 it's because days of sick leave are 0

rename days days_absence
replace days_absence=0 if days_absence==.
drop month year _m

rename CDMANS job_id
rename DEMANS job_description
rename CDRUOL role_id
rename DERUOL role_description

merge 1:1 CDMATR date using "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\roles.dta"

drop if _m==2

rename DEINCA description_additional_role_1
rename DEINCA_2 description_additional_role_2
rename DEINCA_3 description_additional_role_3
rename n_roles number_additional_role

replace number_additional_role=0 if number_additional_role==.

drop CDTINC _m

merge m:1 CDMATR using "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\demographics.dta"

drop if _m==2
drop _m

merge m:1 CDMATR using "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\education.dta"

drop if _m==2
drop _m

merge 1:1 CDMATR date using "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\hours_complete.dta"

replace hour=0 if hour==.
replace minutes=0 if minutes==.

gen hour_contract=hour
gen minutes_contract=minutes

*drop for not employed in that month

drop if days_absence==0 & minutes==0
drop _m

drop if date==tm(2022m11)

gen month = mod(date,12)+1

replace hour=hour-hour*days_absence/31
replace hour=hour-hour*days_absence/30 if month==4 | month==11 | month==6 | month==9
replace hour=hour-hour*days_absence/28 if month==2
replace hour=hour-hour*days_absence/29 if date==tm(2016m2) | date==tm(2020m2)

replace minutes=minutes-minutes*days_absence/31
replace minutes=minutes-minutes*days_absence/30 if month==4 | month==11 | month==6 | month==9
replace minutes=minutes-minutes*days_absence/28 if month==2
replace minutes=minutes-minutes*days_absence/29 if date==tm(2016m2) | date==tm(2020m2)

drop month
sort CDMATR date

merge 1:1 CDMATR date using "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\hours extra activities.dta"

drop if _m==2
replace hour_extra_activities=0 if hour_extra_activities==.
replace minutes_extra_activities=0 if minutes_extra_activities==.

drop _m

merge 1:1 CDMATR date using "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\hours self employed.dta"

drop if _m==2
drop _m

replace hour_self_employed=0 if hour_self_employed==.
replace minutes_self_employed=0 if minutes_self_employe==.


rename CDDISL job_location_code
rename CODL1 location_code_1
rename CODL2 location_code_2
rename CODL3 location_code_3

rename DEDISLP1 description_location_code_1
rename DEDISLP2 description_location_code_2
rename DEDISL description_location_code_3




merge 1:1 CDMATR date using "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\hours availability.dta"

drop if _m==2
drop _m

merge 1:1 CDMATR date using "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\extra_hours.dta"


drop if _m==2
drop _m

replace minutes_availability_basic=0 if minutes_availability_basic==.
replace minutes_availability_medium=0 if minutes_availability_medium==.
replace minutes_availability_premium=0 if minutes_availability_premium==.

replace hours_availability_basic=0 if hours_availability_basic==.
replace hours_availability_medium=0 if hours_availability_medium==.
replace hours_availability_premium=0 if hours_availability_premium==.

replace minutes_over_hours_basic=0 if minutes_over_hours_basic==.
replace minutes_over_hours_medium=0 if minutes_over_hours_medium==.
replace minutes_over_hours_premium=0 if minutes_over_hours_premium==.

replace hour_over_hours_basic=0 if hour_over_hours_basic==.
replace hour_over_hours_medium=0 if hour_over_hours_medium==.
replace hour_over_hours_premium=0 if hour_over_hours_premium==.

**** new definitions of jobs (simplified)

replace job_description="DIRIGENTE PSICOLOGO" if job_description==" PSICOLOGO DIRIGENTE"
replace job_description="ASSISTENTE" if job_description=="ASS. TECNICO PERITO ELETTROTECN. CAT. C"
replace job_description = "ASSISTENTE" if strpos(job_description,"ASSISTENTE")
replace job_description = "ASSISTENTE" if strpos(job_description,"ASSITENTE")
replace job_description = "AUSILIARIO" if strpos(job_description,"AUSILIARIO")
replace job_description = "AUSILIARIO" if strpos(job_description,"AUS. ")
replace job_description = "COAUDIVATORE" if strpos(job_description,"COAD. ")
replace job_description = "COAUDIVATORE" if strpos(job_description,"COAUDIVATORE")
replace job_description = "COLLABORATORE AMMINISTRATIVO" if strpos(job_description,"COLL.AMM.VO")
replace job_description = "COLLABORATORE AMMINISTRATIVO" if strpos(job_description,"COLL. PROF. AMMINISTRATIVO")
replace job_description = "COLLABORATORE AMMINISTRATIVO" if strpos(job_description,"COLLABORATORE AMM.VO")
replace job_description = "COLLABORATORE TECNICO" if strpos(job_description,"COLL. TECNICO PROF.ESP.")
replace job_description = "COLLABORATORE TECNICO" if strpos(job_description,"COLL.TEC.")
replace job_description = "COLLABORATORE PROFESSIONI SANITARIE" if strpos(job_description,"COLL.PROF.SAN.")
replace job_description = "COLLABORATORE PROFESSIONI SANITARIE" if strpos(job_description,"INFERMIERE")
replace job_description = "COLLABORATORE PROFESSIONI SANITARIE" if strpos(job_description,"MASSOFISIOTERAPISTA")
replace job_description = "COMMESSO" if strpos(job_description,"COMMESSO")
replace job_description = "COAUDIVATORE" if strpos(job_description,"COADIUTORE ")
replace job_description = "COLLABORATORE TECNICO" if strpos(job_description,"COLL.TECN.")
replace job_description = "COLLABORATORE PROFESSIONI SANITARIE" if strpos(job_description,"CPS SENIOR OSTETRICA ")
replace job_description = "DIRIGENTE MEDICO" if strpos(job_description,"DIR.MED.")
replace job_description = "DIRIGENTE INFERMIERE" if strpos(job_description,"DIR. PROF.")
replace job_description = "DIRIGENTE MEDICO" if strpos(job_description,"DIR.MED")
replace job_description = "DIRIGENTE MEDICO" if strpos(job_description,"MEDICO PRINC")
replace job_description = "DIRIGENTE INFERMIERE" if strpos(job_description,"DIR.PROF.")
replace job_description = "DIRIGENTE INFERMIERE" if strpos(job_description,"DIR.  PROF.")
replace job_description = "DIRIGENTE INFERMIERE" if strpos(job_description,"DIR.  PR0F.")
replace job_description = "DIRIGENTE INFERMIERE" if strpos(job_description,"DIR.  PR0F.SAN")
replace job_description = "DIRIGENTE FARMACISTA" if strpos(job_description,"DIR.  FARMACISTA ")
replace job_description = "DIRIGENTE FARMACISTA" if strpos(job_description,"DIR.  FARMACISTA")
replace job_description = "DIRIGENTE AMMINISTRATIVO" if strpos(job_description,"DIR. AMMINISTRATIVO")
replace job_description = "DIRIGENTE AMMINISTRATIVO" if strpos(job_description,"DIR. AVVOCATO")
replace job_description = "DIRIGENTE BIOLOGO" if strpos(job_description,"DIR. BIOLOGO")
replace job_description = "DIRIGENTE BIOLOGO" if strpos(job_description,"DIR.  BIOLOGO")
replace job_description = "DIRIGENTE PSICOLOGO" if strpos(job_description,"DIR.  PSICOLOGO")
replace job_description = "ARCHITETTO" if strpos(job_description,"ARCHITETTO")
replace job_description = "DIRIGENTE ODONTOIATRA" if strpos(job_description,"DIR. ODONTOIATRA -")
replace job_description = "OPERATORE TECNICO" if strpos(job_description,"OP.TEC.")
replace job_description = "OPERATORE TECNICO" if strpos(job_description,"OP. TEC.")
replace job_description = "OPERATORE TECNICO" if strpos(job_description,"OPERAIO")
replace job_description = "OPERATORE TECNICO" if strpos(job_description,"CUOCO")
replace job_description = "OPERATORE SOCIO SANITARIO" if strpos(job_description,"OSS")
replace job_description = "DIRIGENTE AMMINISTRATIVO" if strpos(job_description,"COMUNICAZIONE")
replace job_description = "DIRIGENTE CHIMICO" if strpos(job_description,"DIR.  CHIMICO")
replace job_description = "DIRIGENTE SOCIOLOGO" if strpos(job_description,"DIR. SOCIOLOGO")
replace job_description = "DIRIGENTE INGEGNERE" if strpos(job_description,"DIR. INGEGNERE")
replace job_description = "DIRIGENTE FISICO" if strpos(job_description,"DIR.  FISICO")

tab job_description
**************

drop job_id
egen job_id=group(job_description)
tostring job_id, gen(jobid)
drop job_id
rename jobid job_id


*job level

tostring job_level, gen(job_level_new)
replace job_level_new="B" if job_level<32
replace job_level_new="BS" if job_level>31 & job_level<38
replace job_level_new="C" if job_level>37 & job_level<44
replace job_level_new="D" if job_level>43 & job_level<52
replace job_level_new="DS" if job_level>51

***teams

egen team_id= concat(job_id job_location_code date job_level_new)
egen team=group(team_id)

gen birth=year(birth_date)
drop birth_date
gen year=year(dofm(date))
gen month=month(dofm(date))
gen age=year-birth

gen retirement_possible=1 if age>62
replace retirement_possible=0 if retirement_possible==.

replace team_id="" if location_code_1==""
replace team=. if location_code_1==""

*not all employees work in a team (remember that!), variable to identify team members

gen team_member=1 if team!=.
replace team_member=0 if team_member==.

*number of team members

egen team_members = count(team), by(team)

*total number of extra hours

gen over_hour=hour_over_hours_basic+hour_over_hours_medium+hour_over_hours_premium+hours_availability_basic+hours_availability_medium+hours_availability_premium
gen over_minutes=minutes_availability_basic+minutes_availability_medium+minutes_availability_premium+minutes_over_hours_basic+minutes_over_hours_medium+minutes_over_hours_premium

gen change_position=1 if job_level!=job_level[_n-1] & CDMATR==CDMATR[_n-1]
replace change_position=0 if change_position==.

*total number of hours

gen tot_hours=hour+hour_over_hours_basic+hour_over_hours_medium+hour_over_hours_premium
gen tot_minutes=minutes+minutes_over_hours_basic+minutes_over_hours_medium+minutes_over_hours_premium

*create health shock variable

sort CDMATR date
gen moveave1 = (days_absence + L1.days_absence) / 2
replace moveave1=0 if moveave1==.

bysort CDMATR: egen mean = mean(days_absence)


gen health_shock=1 if moveave1>15 
replace health_shock=1 if health_shock[_n+1]==1 & CDMATR==CDMATR[_n+1] & days_absence>2 & days_absence[_n+1]>25
replace health_shock=1 if health_shock[_n+1]==1 & CDMATR==CDMATR[_n+1] & days_absence>4
replace health_shock=1 if health_shock[_n-1]==1 & CDMATR==CDMATR[_n-1] & days_absence>2 & days_absence[_n-1]>25

replace health_shock=0 if health_shock==.

replace health_shock=0 if mean>2
gen cronici=1 if mean>2
replace cronici=0 if cronici==.
rename team_member part_of_team
tab health_shock

*team mate shocks

drop if team==.
gsort team -health_shock
gen team_mate_shock=health_shock
replace team_mate_shock=team_mate_shock[_n-1] if team==team[_n-1]
sort CDMATR date
replace team_mate_shock=team_mate_shock-health_shock

egen job_description_code=group(job_description)

*gen treatment group, constant across time within observations

gen treatment_team_mate_group=1 if team_mate_shock==1
sort CDMATR treatment_team_mate_group
replace treatment_team_mate_group=1 if treatment_team_mate_group[_n-1]==1 & CDMATR==CDMATR[_n-1]
gen treatment_health_shock=1 if health_shock==1
sort CDMATR treatment_health_shock
replace treatment_health_shock=1 if treatment_health_shock[_n-1]==1 & CDMATR==CDMATR[_n-1]

sort CDMATR date
replace treatment_health_shock=0 if treatment_health_shock==.
replace treatment_team_mate_group=0 if treatment_team_mate_group==.


*creation of event study variable


replace team_mate_shock=2 if team_mate_shock[_n-1]==1 & team_mate_shock==0 & CDMATR==CDMATR[_n-1]
replace team_mate_shock=3 if team_mate_shock[_n-1]==2 & team_mate_shock==0 & CDMATR==CDMATR[_n-1]
replace team_mate_shock=4 if team_mate_shock[_n-1]==3 & team_mate_shock==0 & CDMATR==CDMATR[_n-1]
replace team_mate_shock=5 if team_mate_shock[_n-1]==4 & team_mate_shock==0 & CDMATR==CDMATR[_n-1]
replace team_mate_shock=6 if team_mate_shock[_n-1]==5 & team_mate_shock==0 & CDMATR==CDMATR[_n-1]
replace team_mate_shock=7 if team_mate_shock[_n-1]==6 & team_mate_shock==0 & CDMATR==CDMATR[_n-1]
replace team_mate_shock=team_mate_shock+3 if team_mate_shock>0
replace team_mate_shock=3 if team_mate_shock[_n+1]==4 & team_mate_shock==0 & CDMATR==CDMATR[_n+1]
replace team_mate_shock=2 if team_mate_shock[_n+1]==3 & team_mate_shock==0 & CDMATR==CDMATR[_n+1]
replace team_mate_shock=1 if team_mate_shock[_n+1]==2 & team_mate_shock==0 & CDMATR==CDMATR[_n+1]



*keep doctors, nurses, and administration

replace job_level_new="Dirigente" if job_level==.
drop job_level
encode job_level_new, gen(job_level)

*create baseline 2 periods before

replace team_mate_shock=team_mate_shock-1 if team_mate_shock>0
replace team_mate_shock=19 if team_mate_shock==0
replace team_mate_shock=team_mate_shock-1

*increase ESD varible to -9,+9 months

replace team_mate_shock=team_mate_shock+10
replace team_mate_shock=9 if team_mate_shock[_n+1]==10 & CDMATR==CDMATR[_n+1] & team_mate_shock==28
replace team_mate_shock=8 if team_mate_shock[_n+1]==9 & CDMATR==CDMATR[_n+1] & team_mate_shock==28
replace team_mate_shock=7 if team_mate_shock[_n+1]==8 & CDMATR==CDMATR[_n+1] & team_mate_shock==28
replace team_mate_shock=6 if team_mate_shock[_n+1]==7 & CDMATR==CDMATR[_n+1] & team_mate_shock==28



replace team_mate_shock=28 if team_mate_shock<4

*gen event study variable for individual shocks

sort CDMATR date

*generate simple health shock to have a variable that is 1 only in the disease period

gen simple_health_shock=health_shock
replace health_shock=15 if health_shock==0
replace health_shock=health_shock+5 if health_shock==1
replace health_shock=5 if health_shock[_n+1]==6 & CDMATR==CDMATR[_n+1] & health_shock==15
replace health_shock=4 if health_shock[_n+1]==5 & CDMATR==CDMATR[_n+1] & health_shock==15
replace health_shock=3 if health_shock[_n+1]==4 & CDMATR==CDMATR[_n+1] & health_shock==15
replace health_shock=2 if health_shock[_n+1]==3 & CDMATR==CDMATR[_n+1] & health_shock==15
replace health_shock=1 if health_shock[_n+1]==2 & CDMATR==CDMATR[_n+1] & health_shock==15
replace health_shock=0 if health_shock[_n+1]==1 & CDMATR==CDMATR[_n+1] & health_shock==15
replace health_shock=7 if health_shock[_n-1]==6 & CDMATR==CDMATR[_n-1] & health_shock==15
replace health_shock=8 if health_shock[_n-1]==7 & CDMATR==CDMATR[_n-1]& health_shock==15
replace health_shock=9 if health_shock[_n-1]==8 & CDMATR==CDMATR[_n-1] & health_shock==15
replace health_shock=10 if health_shock[_n-1]==9 & CDMATR==CDMATR[_n-1] & health_shock==15
replace health_shock=11 if health_shock[_n-1]==10 & CDMATR==CDMATR[_n-1] & health_shock==15
replace health_shock=12 if health_shock[_n-1]==11 & CDMATR==CDMATR[_n-1] & health_shock==15

*encode gender

encode gender, gen(gender_encode)
replace gender_encode=gender_encode-1

*generate and pre post 6 month treatment

sort CDMATR date
replace team_mate_shock=40 if team_mate_shock[_n-1]==18 & CDMATR==CDMATR[_n-1]
replace team_mate_shock=40 if team_mate_shock[_n-1]==40 & CDMATR==CDMATR[_n-1] & team_mate_shock==28

replace team_mate_shock=2 if team_mate_shock==28 & treatment_team_mate==1

*create all event study dummy

gen D_pre_7_plus=1 if team_mate_shock==2
replace D_pre_7_plus=0 if D_pre_7_plus==.

gen D_pre_6=1 if team_mate_shock==6
replace D_pre_6=0 if D_pre_6==.

gen D_pre_5=1 if team_mate_shock==7
replace D_pre_5=0 if D_pre_5==.

gen D_pre_4=1 if team_mate_shock==8
replace D_pre_4=0 if D_pre_4==.

gen D_pre_3=1 if team_mate_shock==9
replace D_pre_3=0 if D_pre_3==.

gen D_pre_2=1 if team_mate_shock==10
replace D_pre_2=0 if D_pre_2==.

gen D_pre_1=1 if team_mate_shock==11
replace D_pre_1=0 if D_pre_1==.

gen D_0=1 if team_mate_shock==12
replace D_0=0 if D_0==.

gen D_post_1=1 if team_mate_shock==13
replace D_post_1=0 if D_post_1==.

gen D_post_2=1 if team_mate_shock==14
replace D_post_2=0 if D_post_2==.

gen D_post_3=1 if team_mate_shock==15
replace D_post_3=0 if D_post_3==.

gen D_post_4=1 if team_mate_shock==16
replace D_post_4=0 if D_post_4==.

gen D_post_5=1 if team_mate_shock==17
replace D_post_5=0 if D_post_5==.

gen D_post_6=1 if team_mate_shock==18
replace D_post_6=0 if D_post_6==.

gen D_post_7_plus=1 if team_mate_shock==40
replace D_post_7_plus=0 if D_post_7_plus==.

save "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\final dataset and analysis\dataset final - hospital data.dta", replace