clear
import excel "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\raw data\demographics.xlsx", sheet("Esporta foglio di lavoro") firstrow

keep CDMATR GENERE DATANASCI CITTA PROV
rename GENERE gender
rename DATANASCI birth_date
rename CITTA city_residence
rename PROV province_residence

drop if CDMATR==CDMATR[_n-1]


save "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\demographics.dta", replace