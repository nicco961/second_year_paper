clear
import excel "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\raw data\roles.xlsx", sheet("Esporta foglio di lavoro") firstrow

expand 2 
sort CDMATR CDTINC DTINIZ 
quietly by CDMATR CDTINC DTINIZ :  gen dup = cond(_N==1,0,_n)

replace DTINIZ=DTFINE if dup==2
sort CDMATR CDTINC DTINIZ 

keep CDMATR DTINIZ DEINCA CDTINC 

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

keep CDMATR date DEINCA CDTINC

format date %d

egen id=concat(CDMATR DEINCA)

sort id date

egen uniqueid = group(id)

drop id

replace date=d(15nov2022) if date>d(15nov2022)
replace date=d(01jan2016) if date<d(01jan2016)

drop if unique==unique[_n-1] & date ==date[_n-1]

xtset uniqueid date
tsfill

replace CDMATR=CDMATR[_n-1] if CDMATR==.
replace DEINCA=DEINCA[_n-1] if DEINCA==""
replace CDTINC=CDTINC[_n-1] if CDTINC==.

drop uniqueid
sort CDMATR date

gen month=month(date)
gen year=year(date)

drop date
gen date=ym(year,month)
format date %tm

drop month year
sort CDMATR CDTINC date

drop if CDMATR==CDMATR[_n-1] & CDTINC==CDTINC[_n-1] & date==date[_n-1]

sort CDMATR date CDTINC

gen DEINCA_2=""
gen DEINCA_3=""


replace DEINCA_2=DEINCA[_n+1] if CDMATR==CDMATR[_n+1] & date==date[_n+1]

replace DEINCA_3=DEINCA[_n+2] if CDMATR==CDMATR[_n+2] & date==date[_n+2]

gen x=1 if DEINCA_2=="" & DEINCA_2[_n-1]!="" & CDMATR==CDMATR[_n-1] & date==date[_n-1]

drop if x==1
drop x

gen n_roles=2 if DEINCA_2!="" & DEINCA_3==""
replace n_roles=1 if n_roles==.

replace n_roles=3 if DEINCA_3!=""

drop if CDMATR==CDMATR[_n-1] & date==date[_n-1]

save "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\roles.dta", replace
