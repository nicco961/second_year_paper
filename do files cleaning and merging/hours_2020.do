clear
import excel "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\raw data\OREANNO2020.xlsx", sheet("Esporta foglio di lavoro") firstrow

keep CDMATR ANNO MESE MINUTI ORE
rename ANNO year
rename MESE month
rename MINUTI minutes
rename ORE hour

gen date=ym(year,month)

format date %tm

drop year month

sort CDMATR date

replace hour=hour+hour[_n+1] if CDMATR==CDMATR[_n+1] & date==date[_n+1]
replace minutes=minutes+minutes[_n+1] if CDMATR==CDMATR[_n+1] & date==date[_n+1]

drop if CDMATR==CDMATR[_n-1] & date==date[_n-1]

save "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\hours_2020.dta", replace