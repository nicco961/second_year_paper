clear
import excel "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\raw data\departments.xlsx", sheet("Esporta foglio di lavoro") firstrow

rename DTINIZ date

expand 2 
sort CDMATR DEDISLP1 DEDISLP2 DEDISL date
quietly by CDMATR DEDISLP1 DEDISLP2 DEDISL date:  gen dup = cond(_N==1,0,_n)

drop if dup>2
replace date=DTFINE if dup==2


 
*expand to create two observations, one for the start of the contract, the second for the end

drop DTFINE dup 



sort CDMATR date

drop if date==date[_n-1] & CDMATR==CDMATR[_n-1]



generate newdate = string(date, "%td")
gen month=substr(newdate,3,3)
gen year=substr(newdate,6,4)

replace month="1" if month=="jan"
replace month="2" if month=="feb"
replace month="3" if month=="mar"
replace month="4" if month=="apr"
replace month="5" if month=="may"
replace month="6" if month=="jun"
replace month="7" if month=="jul"
replace month="8" if month=="aug"
replace month="9" if month=="sep"
replace month="10" if month=="oct"
replace month="11" if month=="nov"
replace month="12" if month=="dec"

rename month month_clean
destring month_clean, gen(newmonth)

rename year year_clean
destring year_clean, gen(newyear)

gen use1=1 if newmonth==newmonth[_n+1] & newyear==newyear[_n+1] & newmonth==1
replace newmonth=newmonth-1 if newmonth==newmonth[_n+1] & newyear==newyear[_n+1] & newmonth!=1
replace newmonth=12 if use1==1
replace newyear=newyear-1 if use1==1
drop use
rename newmonth month
rename newyear year

drop if month==month[_n+1] & year==year[_n+1]

sort CDMATR year month

drop date
replace year=2023 if year>2022

gen date=ym(year,month)
format date %tm

drop newdate month_clean year_clean CDAZIE


xtset CDMATR date
tsfill


replace CDDISL=CDDISL[_n-1] if CDDISL==""
replace CODL1=CODL1[_n-1] if CODL1==""
replace CODL2=CODL2[_n-1] if CODL2==""
replace CODL3=CODL3[_n-1] if CODL3==""
replace DEDISLP1=DEDISLP1[_n-1] if DEDISLP1==""
replace DEDISLP2=DEDISLP2[_n-1] if DEDISLP2==""
replace DEDISL=DEDISL[_n-1] if DEDISL==""

drop if date > tm(2022m11)
drop if date < tm(2016m1)


save "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\departments.dta", replace
