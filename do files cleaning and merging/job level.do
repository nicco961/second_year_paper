clear
import excel "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\raw data\CATEGORIAFASCIA.xlsx", sheet("Esporta foglio di lavoro") firstrow

replace CDVARI3 = subinstr(CDVARI3,"01","",.)
replace CDVARI3 = subinstr(CDVARI3,".","",.)

expand 2 
keep CDMATR DTINIZ DTFINE CDVARI3

sort CDMATR CDVARI3 DTINIZ 
quietly by CDMATR CDVARI3 DTINIZ  :  gen dup = cond(_N==1,0,_n)



replace DTINIZ=DTFINE if dup==2
sort CDMATR CDVARI3 DTINIZ 


generate newdate = string(DTINIZ, "%td")
gen day=substr(newdate,1,2)
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

rename day day_clean
destring day_clean, gen(newday)

rename month month_clean
destring month_clean, gen(newmonth)

rename year year_clean
destring year_clean, gen(newyear)

recast int newday
recast int newmonth


gen date = mdy(newmonth, newday, newyear)

replace date=date+cofd(1) if CDMATR==CDMATR[_n-1] & date==date[_n-1]

keep CDMATR date CDVARI3

format date %d


replace date=d(15nov2022) if date>d(15nov2022)
replace date=d(01jan2016) if date<d(01jan2016)

drop if CDMATR==CDMATR[_n-1] & date ==date[_n-1]
sort CDMATR date
drop if CDMATR==CDMATR[_n-1] & date ==date[_n-1]

xtset CDMATR date
tsfill

encode CDVARI3, gen(job_level)

replace job_level=job_level[_n-1] if job_level==.

sort CDMATR date

gen month=month(date)
gen year=year(date)

drop date
gen date=ym(year,month)
format date %tm

drop month year CDVARI3

drop if date>tm(2022m10)
drop if date<tm(2016m1)
drop if date==date[_n-1] & CDMATR==CDMATR[_n-1]


save "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\job levels.dta", replace