clear
import excel "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\raw data\professional profile.xlsx", sheet("Esporta foglio di lavoro") firstrow

generate start_date = string(DTINI, "%td")
gen month_start=substr(start_date,3,3)
gen year_start=substr(start_date,6,4)

replace month_start="1" if month_start=="jan"
replace month_start="2" if month_start=="feb"
replace month_start="3" if month_start=="mar"
replace month_start="4" if month_start=="apr"
replace month_start="5" if month_start=="may"
replace month_start="6" if month_start=="jun"
replace month_start="7" if month_start=="jul"
replace month_start="8" if month_start=="aug"
replace month_start="9" if month_start=="sep"
replace month_start="10" if month_start=="oct"
replace month_start="11" if month_start=="nov"
replace month_start="12" if month_start=="dec"

generate end_date = string(DTFINE, "%td")
gen month_end=substr(end_date,3,3)
gen year_end=substr(end_date,6,4)

replace month_end="1" if month_end=="jan"
replace month_end="2" if month_end=="feb"
replace month_end="3" if month_end=="mar"
replace month_end="4" if month_end=="apr"
replace month_end="5" if month_end=="may"
replace month_end="6" if month_end=="jun"
replace month_end="7" if month_end=="jul"
replace month_end="8" if month_end=="aug"
replace month_end="9" if month_end=="sep"
replace month_end="10" if month_end=="oct"
replace month_end="11" if month_end=="nov"
replace month_end="12" if month_end=="dec"

rename month_start month_clean_start
rename month_end month_clean_end

destring month_clean_start, gen(month_start)
destring month_clean_end, gen(month_end)

rename year_start year_clean_start
rename year_end year_clean_end

destring year_clean_start, gen(year_start)
destring year_clean_end, gen(year_end)

drop DTFINE DTINI month_clean_end month_clean_start start_date end_date year_clean_end year_clean_start

expand 2  
*expand to create two observations, one for the start of the contract, the second for the end

sort CDAZIE CDMATR CDMANS DEMANS CDRUOL month_start year_start month_end year_end
quietly by CDAZIE CDMATR CDMANS DEMANS CDRUOL month_start year_start month_end year_end:  gen dup = cond(_N==1,0,_n)
drop if dup>2

sort CDMATR year_start month_start

replace month_start=month_end if dup==2
replace year_start=year_end if dup==2
 
rename month_start month
rename year_start year

drop month_end year_end dup

sort CDMATR year month DEMANS

replace month=1 if year<2016
replace year=2016 if year<2016

replace month=11 if year>2021 & month>11
replace month=11 if year>2022
replace year=2022 if year>2022

sort CDMATR year month

gen newdate=ym(year,month)

format newdate %tm

replace DEMANS=DEMANS[_n-1] if DEMANS==DEMANS[_n-2] & CDMATR==CDMATR[_n-2]
drop if newdate==newdate[_n-2] & DEMANS==DEMANS[_n-2] & CDMATR==CDMATR[_n-2]
drop if newdate==newdate[_n-1] & DEMANS==DEMANS[_n-1] & CDMATR==CDMATR[_n-1]
drop if CDMATR==CDMATR[_n+1] & newdate==newdate[_n+1]

rename newdate date

drop CDAZIE 

sort CDMATR date

xtset CDMATR date
tsfill

replace CDMANS=CDMANS[_n-1] if CDMANS==""
replace DEMANS=DEMANS[_n-1] if DEMANS==""
replace CDRUOL=CDRUOL[_n-1] if CDRUOL==""
replace DERUOL=DERUOL[_n-1] if DERUOL==""
drop year


save "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\professional profiles.dta", replace
/*get changes of roles

gen x=1 if CDMANS!= CDMANS[_n-1] & CDMATR== CDMATR[_n-1]
replace x=1 if x[_n+1]==1
keep if x==1
*health workers
keep if CDRUOL=="01"
*other workers (keep if CDRUOL!="01")*/

