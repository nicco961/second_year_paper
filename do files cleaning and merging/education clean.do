clear
import excel "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\raw data\education.xlsx", sheet("XLS") firstrow

rename J DETIT

generate start_date = string(ASSUNTO, "%td")
gen year_start=substr(start_date,6,4)
destring year_start, gen(hiring_year)
sort CDMATR

replace LaureaDESCRIZIONE=DETIT if LaureaDESCRIZIONE==""

drop DETIT

keep CDMATR LaureaDESCRIZIONE hiring_year

rename LaureaDESCRIZIONE degree

drop if CDMATR== CDMATR[_n-1]

encode degree, gen(degree_code)

save "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\education.dta", replace