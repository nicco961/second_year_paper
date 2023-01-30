clear
import excel "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\raw data\ORELIBERAPROFESSIONE.xlsx", sheet("Esporta foglio di lavoro") firstrow

keep CDMATR ANNO MESE MINUTI ORE
rename ANNO year
rename MESE month
rename MINUTI minutes_self_employed
rename ORE hour_self_employed

gen date=ym(year,month)

format date %tm

drop year month

sort CDMATR date

drop if CDMATR==CDMATR[_n-1] & date==date[_n-1]

save "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\hours self employed.dta", replace