clear 

import excel "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\raw data\STRCOMPARTO.xlsx", sheet("Esporta foglio di lavoro") firstrow

rename ANNO year
rename MESE month
rename MINUTI minutes_over_hours
rename ORE hour_over_hours
rename DETOME over_hour_type

gen date=ym(year,month)

format date %tm

drop year month CDTOME

egen id=group(over_hour_type)
drop over_hour_type

reshape wide minutes_over_hours hour_over_hours, i(CDMATR date) j(id)

*simple x1.15
*medium x1.3
*premium x1.5

rename minutes_over_hours1 minutes_over_hours_basic
rename minutes_over_hours2 minutes_over_hours_medium
rename minutes_over_hours3 minutes_over_hours_premium

rename hour_over_hours1 hour_over_hours_basic
rename hour_over_hours2 hour_over_hours_medium
rename hour_over_hours3 hour_over_hours_premium

save "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\extra_hours.dta", replace