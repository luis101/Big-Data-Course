


******Adjusting company files:


clear

insheet using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\....csv", delimiter(;)

drop if _n <= 2

rename v1 date
rename v2 price
rename v3 marketvalue
rename v4 dividendyield
rename v5 priceindex
rename v6 adjustmentfactor
rename v7 adjustcoefficient
drop v8
rename v9 earningspershare
drop v10
drop v11 
drop v12 
rename v13 returnindex
rename v14 totalreturnindex
drop v15
rename v16 turnovervolume
rename v17 bookvaluepershare
rename v18 cash
rename v19 CAPX
rename v20 commonequity
rename v21 EBIT
rename v22 EBITDA
rename v23 employees
rename v24 grossincome
drop v25 
rename v26 operatingincome
rename v27 netincome
rename v28 ppegt
rename v29 at
rename v30 totalcapital
rename v31 totaldebt
rename v32 tdceq
rename v33 tdtc
rename v34 lt
rename v35 ltteq
rename v36 teq
rename v37 workingcapital
drop v38 
drop v39
drop v40 
rename v41 pricetobook
rename v42 sales
 
gen comnpame = "..."
gen compid = ... 
 
save "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\....dta", replace



******Generating data set:


set more off

use "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Adidas.dta", clear
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Allianz.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\BASF.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Bayer.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Beiersdorf.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\BMW.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Commerzbank.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Continental.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Daimler.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Deutsche Bank.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Deutsche Boerse.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Deutsche Lufthansa.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Deutsche Post.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Deutsche Telekom.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\EON.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Fresenius.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Fresenius Medical Care.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\HeidelbergCement.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Henkel.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Infineon.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\K+S.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Lanxess.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Linde.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Merck.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Metro.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\MunichRe.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\RWE.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Salzgitter.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\SAP.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Siemens.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\ThyssenKrupp.dta"
append using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\Volkswagen.dta"


save "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\germandaxdata.dta", replace  
  
  
local var = "price marketvalue dividendyield priceindex adjustmentfactor earningspershare returnindex totalreturnindex \\\
turnovervolume bookvaluepershare cash CAPX commonequity EBIT EBITDA employees grossincome operatingincome \\\
netincome ppegt at totalcapital totaldebt tdceq tdtc lt ltteq teq workingcapital pricetobook sales"

foreach v of local var {
  replace `v' = "." if `v' == ""
  replace `v' = "." if `v' == ", 4540, NO DATA VALUES FOUND"
  
  destring `v', replace dpcomma
}
 
rename date strdate
gen date = date(strdate, "DMY")
format date %d
rename comnpame compname


save "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\germandaxdata.dta", replace  



******Preparing News Analysis and Merging:


clear

insheet using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\..._results.csv", delimiter(;)

rename v1 strdate
rename v2 positive
rename v3 negative
gen date = date(strdate, "DMY")
format date %d

gen comnpame = "..."
gen compid = ... 

save "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\..._results.dta", replace


clear


use "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\germandaxdata.dta"

merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Adidas_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Allianz_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\BASF_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Bayer_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Beiersdorf_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\BMW_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Commerzbank_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Continental_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Daimler_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Deutsche Bank_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Deutsche Boerse_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Deutsche Lufthansa_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Deutsche Post_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Deutsche Telekom_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\EON_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Fresenius_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\FreseniusMedicalCare_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Fresenius_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\HeidelbergCement_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Henkel_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Infineon_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\KuS_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Lanxess_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Merck_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Metro_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\MunichRe_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\RWE_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Salzgitter_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\SAP_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Siemens_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\ThyssenKrupp_results.dta", nogen
merge n:m compid date using "C:\Users\lukazimm\Documents\Big Data\Text_Project\WordCounts\Volkswagen_results.dta", nogen

drop if date == .
drop adjustcoefficient
drop v4 v5 v6 v7 v8

sort compid date
by compid date: egen neg = total(negative)
by compid date: egen pos = total(positive)
duplicates drop compid date, force

xtset compid date

save "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\germandaxdata.dta", replace  


******Regression Analysis:

use "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\germandaxdata.dta", clear

*daily data:

gen lprice = l1.price
gen ret = (price-lprice)/lprice
gen l3prc = l3.price
replace ret = (l3prc-price)/price if ret == .

gen lret = l1.ret
replace lret = l2.ret if lret == .
replace lret = l3.ret if lret == .

gen ng = neg
replace ng = . if negative == .
gen psv = pos
replace psv = . if positive == .
gen pes = neg-pos
gen psm = pes
replace psm = . if positive == . & negative == .

gen l1neg = l1.neg 
gen l2neg = l2.neg
gen l3neg = l3.neg
gen l4neg = l4.neg
gen l5neg = l5.neg

gen l1pos = l1.pos
gen l2pos = l2.pos
gen l3pos = l3.pos 
gen l4pos = l4.pos
gen l5pos = l5.pos

gen l1pes = l1.pes
gen l2pes = l2.pes
gen l3pes = l3.pes
gen l4pes = l4.pes
gen l5pes = l5.pes

reg ret l1pos l2pos l3pos l4pos l5pos lret, robust
est store ta1
reg ret l1neg l2neg l3neg l4neg l5neg lret, robust
est store ta2
reg ret l1pes l2pes l3pes l4pes l5pes lret, robust
est store ta3

xtreg ret l1pos l2pos l3pos l4pos l5pos lret, fe
est store ddfe1
xtreg ret l1neg l2neg l3neg l4neg l5neg lret, fe
est store ddfe2
xtreg ret l1pes l2pes l3pes l4pes l5pes lret, fe
est store ddfe3

reg ret l1pos l1neg lret, robust
est store ta4
reg ret l2pos l2neg lret, robust
est store ta5
reg ret pos neg lret, robust
est store ta6

xtreg ret l1pos l1neg lret, fe
est store ddfe4
xtreg ret l2pos l2neg lret, fe
est store ddfe5
xtreg ret pos neg lret, fe
est store ddfe6

gen pos_dum = (pos>0)
gen neg_dum = (neg>0)
gen pos_nw =(pos>neg)
gen neg_nw =(neg>pos)
gen year = year(date)

sort compid year
by compid year: egen psy = total(pos_dum)
by compid year: egen ngy = total(neg_dum)
by compid year: egen ps_nw = total(pos_nw)
by compid year: egen ng_nw = total(neg_nw)

*week of the month:

gen sdate = word("`c(Weekdays)'",dow(date))
gen MD = (sdate == "Monday")
gen TU = (sdate == "Tuesday")
gen WD = (sdate == "Wednesday")
gen TH = (sdate == "Thursday")
gen FR = (sdate == "Friday")

reg ret l1pos l2pos l3pos l4pos l5pos lret MD TU WD TH, robust
est store wd1
reg ret l1neg l2neg l3neg l4neg l5neg lret MD TU WD TH, robust
est store wd2
reg ret l1pes l2pes l3pes l4pes l5pes lret MD TU WD TH, robust
est store wd3

reg ret l1pos l2pos l3pos l4pos l5pos lret if sdate != "Monday", robust
est store om1
reg ret l1neg l2neg l3neg l4neg l5neg lret if sdate != "Monday", robust
est store om2
reg ret l1pes l2pes l3pes l4pes l5pes lret if sdate != "Monday", robust
est store om3


**Graphs:

replace l1neg = . if l1neg == 0
replace l2neg = . if l2neg == 0

replace l1pos = . if l1pos == 0
replace l2pos = . if l2pos == 0


scatter ret l1neg, msize(medium) msymbol(circle) mcolor("25 50 190") ytitle("Return") xtitle("Percentage of Negative Words") legend(off) b1title(Blue: One Day Lagged News, box) || ///
scatter ret l2neg, msize(vsmall) msymbol(square) mcolor("200 100 130") ytitle("Return") xtitle("Percentage of Negative Words") legend(off) b2title(Red: Two Day Lagged News, box)

scatter ret l1pos, msize(medium) msymbol(circle) mcolor("20 40 130") ytitle("Return") xtitle("Percentage of Positive Words") legend(off) b1title(Blue: One Day Lagged News, box) || ///
scatter ret l2pos, msize(vsmall) msymbol(square) mcolor("120 180 150") ytitle("Return") xtitle("Percentage of Positive Words") legend(off) b2title(Red: Two Day Lagged News, box)




*yearly data:

collapse (lastnm) price marketvalue dividendyield priceindex earningspershare turnovervolume ///
bookvaluepershare cash CAPX commonequity EBIT EBITDA employees grossincome operatingincome netincome ///
ppegt at totalcapital totaldebt lt teq workingcapital pricetobook sales compname date psy ngy ps_nw ng_nw, by(compid year)

drop if year == 2004

xtset compid year

gen lemp = l1.employees
gen delta_emp = (employees-lemp)/lemp

reg delta_emp ngy psy, robust
est store ya1
reg delta_emp ps_nw ng_nw, robust
est store ya11

gen req = EBIT/commonequity

reg req ngy psy, robust
est store ya2
reg req ps_nw ng_nw, robust
est store ya22
reg dividendyield ngy psy, robust
est store ya3
reg dividendyield ps_nw ng_nw, robust
est store ya33

gen inv = (CAPX/sales)*100
gen me = ln(marketvalue)

reg inv psy ngy, robust
est store ya4
reg inv ps_nw ng_nw, robust
est store ya44
reg me psy ngy, robust
est store ya5
reg me ps_nw ng_nw, robust
est store ya55

gen fa = ppegt/at
gen lv = totaldebt/at

reg fa psy ngy, robust
est store ya6
reg fa ps_nw ng_nw, robust
est store ya66
reg lv psy ngy, robust
est store ya7
reg lv ps_nw ng_nw, robust
est store ya77


gen lprice = l1.price
gen ret = (price-lprice)/price
reg ret psy ngy, robust
est store ya8
reg ret ps_nw ng_nw, robust
est store ya88

xtreg delta_emp ngy psy, fe
est store yfe1
xtreg delta_emp ps_nw ng_nw, fe
est store yfe11
xtreg req ngy psy, fe
est store yfe2
xtreg req ps_nw ng_nw, fe
est store yfe22
xtreg dividendyield ngy psy, fe
est store yfe3
xtreg dividendyield ps_nw ng_nw, fe
est store yfe33
xtreg inv psy ngy, fe
est store yfe4
xtreg inv ps_nw ng_nw, fe
est store yfe44
xtreg me psy ngy, fe
est store yfe5
xtreg me ps_nw ng_nw, fe
est store yfe55
xtreg fa psy ngy, fe
est store yfe6
xtreg fa ps_nw ng_nw, fe
est store yfe66
xtreg lv ngy psy, fe
est store yfe7
xtreg lv ps_nw ng_nw, fe
est store yfe77
xtreg ret psy ngy, fe
est store yfe8
xtreg ret ps_nw ng_nw, fe
est store yfe88


**Graphs:

scatter delta_emp ngy, msize(medium) msymbol(circle) mcolor(red) ytitle("Percentage Change in Number of Employees") xtitle("Negative(Red)/Positive(Green) Word News Number") legend(off) || ///
scatter delta_emp psy, msize(medsmall) msymbol(circle) mcolor(green) ytitle("Percentage Change in Number of Employees") xtitle("Negative(Red)/Positive(Green) Word News Number") legend(off)

scatter inv ngy, msize(medium) msymbol(circle) mcolor(red) ytitle("Investment Expenditures") xtitle("Negative(Red)/Positive(Green) Word News Number") legend(off) || ///
scatter inv psy, msize(medsmall) msymbol(circle) mcolor(green) ytitle("Investment Expenditures") xtitle("Negative(Red)/Positive(Green) Word News Number") legend(off)

scatter me ngy, msize(medium) msymbol(circle) mcolor(red) ytitle("Size") xtitle("Negative(Red)/Positive(Green) Word News Number") legend(off) || ///
scatter me psy, msize(medsmall) msymbol(circle) mcolor(green) ytitle("Size") xtitle("Negative(Red)/Positive(Green) Word News Number") legend(off)

scatter fa ngy, msize(medium) msymbol(circle) mcolor(red) ytitle("Fixed Assets (Industry Proxy)") xtitle("Negative(Red)/Positive(Green) Word News Number") legend(off) || ///
scatter fa psy, msize(medsmall) msymbol(circle) mcolor(green) ytitle("Fixed Assets (Industry Proxy)") xtitle("Negative(Red)/Positive(Green) Word News Number") legend(off)


**Saving Tables:

esttab ta1 ta2 ta3 ta4 ta5 using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\dailyanalysis.rtf", replace cells(b(fmt(%12.5f) star) ///
t(fmt(%12.3f) par)) starlevels(* 0.10 ** 0.05 *** 0.01) legend noobs title(Regression Analysis - Daily Data) unstack model(6)

esttab ddfe1 ddfe2 ddfe3 ddfe4 ddfe5 using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\dailyanalysisfe.rtf", replace cells(b(fmt(%12.5f) star) ///
t(fmt(%12.3f) par)) starlevels(* 0.10 ** 0.05 *** 0.01) legend noobs title(Regression Analysis - Daily Data) unstack model(6)

esttab wd1 wd2 wd3 om1 om2 om3 using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\dailyanalysisdayeffect.rtf", replace cells(b(fmt(%12.5f) star) ///
t(fmt(%12.3f) par)) starlevels(* 0.10 ** 0.05 *** 0.01) legend noobs title(Regression Analysis - Daily Data) unstack model(6)

esttab ya1 ya2 ya3 ya4 ya5 ya6 ya7 ya8 ya11 ya22 ya33 ya44 ya55 ya66 ya77 ya88 using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\yearlyanalysis.rtf", replace cells(b(fmt(%12.5f) star) ///
t(fmt(%12.3f) par)) starlevels(* 0.10 ** 0.05 *** 0.01) legend noobs title(Regression Analysis - Yearly Data) unstack model(6)

esttab yfe1 yfe2 yfe3 yfe4 yfe5 yfe6 yfe7 yfe8 yfe11 yfe22 yfe33 yfe44 yfe55 yfe66 yfe77 yfe88 using "C:\Users\lukazimm\Documents\Big Data\CompanyFiles\yearlyanalysisfe.rtf", replace cells(b(fmt(%12.5f) star) ///
t(fmt(%12.3f) par)) starlevels(* 0.10 ** 0.05 *** 0.01) legend noobs title(Regression Analysis - Yearly Data) unstack model(6)



