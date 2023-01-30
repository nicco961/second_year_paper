clear
use "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\hours_2016.dta"

append using "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\hours_2017.dta" "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\hours_2018.dta" "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\hours_2019.dta" "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\hours_2020.dta" "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\hours_2021.dta" "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\hours_2022.dta"

save "C:\Users\nicco\OneDrive\Desktop\On the job training and career outcomes\dataset\single datasets\hours_complete.dta", replace