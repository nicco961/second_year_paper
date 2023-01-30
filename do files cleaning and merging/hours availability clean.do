clear
import excel "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\raw data\STRREPCOMPARTO.xlsx", sheet("Esporta foglio di lavoro") firstrow


rename ANNO year
rename MESE month
rename MINUTI minutes_availability
rename ORE hour_availability


replace CDTOME=20 if CDTOME==430
replace CDTOME=19 if CDTOME==429
replace CDTOME=18 if CDTOME==428


gen date=ym(year,month)

format date %tm

drop year month DETOME

egen id=group(CDTOME)
drop CDTOME

reshape wide hour_availability minutes_availability, i(CDMATR date) j(id)

rename minutes_availability1 minutes_availability_basic
rename minutes_availability2 minutes_availability_medium
rename minutes_availability3 minutes_availability_premium

rename hour_availability1 hours_availability_basic
rename hour_availability2 hours_availability_medium
rename hour_availability3 hours_availability_premium

*simple x1.15
*medium x1.3
*premium x1.5

save "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\hours availability.dta", replace

