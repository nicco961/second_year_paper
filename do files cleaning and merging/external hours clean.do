clear
import excel "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\raw data\ORELIBERAPROFESSIONE.xlsx", sheet("Esporta foglio di lavoro") firstrow

keep CDMATR ANNO MESE MINUTI ORE
rename ANNO year
rename MESE month
rename MINUTI minutes_external_work
rename ORE hours_external_work

