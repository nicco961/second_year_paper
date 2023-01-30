clear

import excel "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\raw data\absentees.xlsx", sheet("Esporta foglio di lavoro") firstrow

drop CDAZIE DESCRIZIONEQUAL CODICEASS DESCRIZIONEASSE

rename ANNO year
rename MESE month
rename NUMEROGIORNI days_absensce

gen date=ym(year,month)
format date %tm

sort CDMATR date

/*xtset CDMATR date
tsfill
replace days_absensce=0 if days_absensce==.

rename days_absensce days_absence


gen moveave1 = (F1.days_absence + days_absence + L1.days_absence) / 3
replace moveave1=0 if moveave1==.

bysort CDMATR: egen mean = mean(days_absence)

gen x=1 if moveave1>15
replace x=0 if x==.


replace x=0 if mean>2
gen cronici=1 if mean>2
replace cronici=0 if cronici==.

replace x=4 if x==1
replace x=5 if x[_n-1]==4 & CDMATR==CDMATR[_n-1]
replace x=6 if x[_n-1]==5 & CDMATR==CDMATR[_n-1]
replace x=7 if x[_n-1]==6 & CDMATR==CDMATR[_n-1]
replace x=8 if x[_n-1]==7 & CDMATR==CDMATR[_n-1]
replace x=9 if x[_n-1]==8 & CDMATR==CDMATR[_n-1]
replace x=10 if x[_n-1]==9 & CDMATR==CDMATR[_n-1]
replace x=3 if x[_n+1]==4 & CDMATR==CDMATR[_n+1]
replace x=2 if x[_n+1]==3 & CDMATR==CDMATR[_n+1]
replace x=1 if x[_n+1]==2 & CDMATR==CDMATR[_n+1]

xtreg days_absence i.x i.date i.cronici
coefplot, vertical keep(1.x 2.x 3.x 4.x 5.x 6.x 7.x 8.x 9.x 10.x)*/

save "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\absentees.dta", replace

