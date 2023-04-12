****************************************************************************************************
**************************************** Ukrainian values ******************************************
****************************************************************************************************

*specify the working directory containing the datasets 
global path "SPECIFY YOUR WORKING DIRECTORY"

*open the data file
use "$path\EVS_WVS_Joint_v2_0", clear

	* preparing the variables 
	rename cntry country 
	rename reg_iso region
	rename lnge_num language_inter 
	rename F025 religion
		recode religion 0=1 1=2 2=2 3=0 4=3 5=3 6=3 7=3 8=3 9=3 if country == 804
			label define lreligion 0 "Orthodox" 1"Non-religious" 2"Catholic/Protesatnt" 3 "Other"
			label values religion lreligion
	rename reg_nuts1 nuts1

		mvdecode X047_WVS7 X047E_EVS5 , mv(-1 -2 -3 -4 -5) 
	gen income =  X047_WVS7 if country == 804 
	replace income = X047E_EVS5 if X047_WVS7 == . & country == 804 
	
	rename X025R education3
	rename X025A_01 education8
	rename V004AF_01 edu_fath8
	rename V004RF edu_fath3
	rename X003R2 age3
	rename X003R age6
	rename X003 age
	rename X001 sex
	rename size_5c city_size 
	rename  X028 empstatus
	
	
	* creating a variable for EU-membership
	gen EU_mem = 0
	replace EU_mem = 1 if country == 40 | country == 100 | country == 191 | country == 196 | country == 203 | country == 208 | country ==233 |country == 246 |country == 250 | country == 276 | country == 300 | country == 348 | country == 380 | country == 440 | country == 528 | country == 616 | country == 620 | country == 642 | country == 703 | country == 705 | country == 724 | country == 752
	
	*keeping only EU-members, Ukraine and Russia
	keep if EU_mem == 1 | country == 643 | country == 804
	
	* recoding the missing values
	mvdecode _all  , mv(-1 -2 -3 -4 -5) 
	
	
	* editing the weights. Some countries were surveyed twice so I am creating the average and then I devide it by two for the countries that were surveyed twice
	bysort country: egen pop_weights = mean(pwght)
		replace pop_weights = pop_weights/2 if country == 643 | country == 804 | country == 276 | country == 642 
			label variable pop_weights "Population weights"
	
	bysort country: egen equal_weights1000 = mean(wght_eq1000)
		replace equal_weights1000 = equal_weights1000/2 if country == 643 | country == 804 | country == 276 | country == 642 
			label variable equal_weights1000 "Equalibrated weights 1000"
	
	* keeping only the necessary items
	keep country study A029 A042 F118 F120 F121 A124_02 A124_06 F114 F116 F117 C001 E114 E116 E117 C002 C002_01 C001_01 D059 D060 D078 D054 D026_05 G052    nuts1  income education3 education8 edu_fath8 edu_fath3 age age3 age6 sex city_size religion empstatus language_inter region study religion nuts1 EU_mem pop_weights equal_weights1000 gwght 



	* Preparing the items for the EU-values scales  

	* Recoding the variables to (1) vary between 1 and 100, and (2) to be ordered from higher support for EU-values to lower support

* 1 Individual freedom 
	gen homosexuality = ((F118-1)/9)*100
	drop F118
	gen abortion = ((F120-1)/9)*100
	drop F120
	gen divorce = ((F121-1)/9)*100
	drop F121
	
	
* 2. Autonomy 
	recode A029 1 = 100
	rename A029 independent

	recode A042 1=0 0=100 
	rename A042 obedience
	
	recode D054 1=0 2=33 3=66 4=100
	rename D054 parents_proud
	
	recode D026_05 1=0 2=25 3=50 4=75 5=100
	rename D026_05 parents_ill

* 4. Ethnic tolerance 
	recode A124_02 0=100 1=0
	rename A124_02 neigh_race
	
	recode A124_06 0=100 1=0
	rename A124_06 neigh_immig 
	
	recode C002_01 1=0 2=25 3=50 4=75 5=100
	rename C002_01 immig_jobs
	
	recode G052 1=0 2=25 3=50 4=75 5=100
	rename G052 immig_socimpact
	
* 5. Civic honesty 
	recode F114 1=100 2=89 3=78 4=67 5=56 6=44 7=33 8=22 9=11 10=0
	rename F114 just_benefit
	
	recode F116 1=100 2=89 3=78 4=67 5=56 6=44 7=33 8=22 9=11 10=0
	rename F116 just_tax
	
	recode F117 1=100 2=89 3=78 4=67 5=56 6=44 7=33 8=22 9=11 10=0
	rename F117 just_bribe	
	
* 6. Gender Equality 
	recode C001_01 1=0 2=25 3=50 4=75 5=100
	rename C001_01 gender_job_1
	
	* This item is the same as the previous but had 3 categories instead of 5 
	recode C001 1=0 2=100 3=50
	rename C001 gender_job_2 
	
	*Therefore, compute the mean between them because the second one is more refined (the correlation between them on the individual level is .913)
	egen gender_job = rowmean(gender_job_1 gender_job_2) 
	drop gender_job_1 gender_job_2
	
	recode D059 1=0 2=33 3=66 4=100
	rename D059 gender_pol
	
	recode D060 1=0 2=33 3=66 4=100
	rename D060 gender_edu
		
	recode D078 1=0 2=33 3=66 4=100
	rename D078 gender_business
	
	
* 7. Liberal democracy 
	recode E114 1=0 2=33 3=66 4=100
	rename E114 dem_leader
	
	recode E116 1=0 2=33 3=66 4=100
	rename E116 dem_army	
	
	recode E117 1=100 2=66 3=33 4=0
	rename E117 dem_system	

	

	
	* Creating comparison groups 

	gen region_UKR = 0 
	replace region_UKR = 1 if region == 804005 | region == 804007 | region == 804018 | region == 804021 | region == 804026 |region == 804032 | region == 804046 | region == 804035 | region == 804056 | region == 804061 | region == 804068 | region == 804071 | region == 804077 
	 replace region_UKR = 2 if region == 804009 | region == 804012 | region == 804014 | region == 804023 | region == 804048  | region == 804051 | region == 804053 | region == 804059 | region == 804063 | region == 804065 | region == 804074 
	replace region_UKR = 3 if region == 804030 
		label define lregion_UKR 1 "Ukraine-West" 2 "Ukraine-East/South"  3"Kiyv"
		label value region_UKR lregion_UKR
	
	
	gen country2= country 
		replace country2= 1000 if country == 804 & region_UKR == 1 
		replace country2= 1001 if country == 804 & region_UKR == 2 
		replace country2= 1002 if country == 804 & region_UKR == 3
			label copy CNTRY country2_split_reg
			label define country2_split_reg 1000 "Ukraine-West" 1001 "Ukraine-East/South"  1002 "Kiyv", add
			label value country2 country2_split_reg
	
		
	gen EU_old_mem = 0
		replace EU_old_mem = 1 if country ==  40 | country == 208 | country == 246 | country == 250 | country ==276 | country == 300 | country == 380 | country == 528 | country == 620 | country == 724 | country == 752
		replace EU_old_mem = . if country == 643 | country == 804 //Russia and Ukraine
	
	gen groups = 0
		replace groups = 1 if EU_old_mem == 1
		replace groups = 2 if EU_old_mem == 0
			expand 2 if country == 804, gen (duplicate)
		replace groups = 3 if country == 804 & region_UKR == 1 & duplicate == 1
		replace groups = 4 if country == 804 & region_UKR == 2 & duplicate == 1
		replace groups = 5 if country == 804 & region_UKR == 3 & duplicate == 1
		replace groups = 6 if country == 804 & duplicate == 0 
		replace groups = 7 if country == 643
			label variable groups "Comparison groups"
			label define lgroups 1"Old EU-members" 2"New EU-members" 3"Ukraine - West" 4"Ukraine - East/South" 5"Kiyv" 6"Whole Ukraine" 7"Russia"
			label values groups lgroups
			
			
	gen groups2 = 0 
		replace groups2 = 1 if EU_old_mem == 1 & age <47
		replace groups2 = 2 if EU_old_mem == 1 & age >46
		replace groups2 = 3 if EU_old_mem == 0 & age <47
		replace groups2 = 4 if EU_old_mem == 0 & age >46
		replace groups2 = 5 if country == 804 & age <47 & duplicate == 0
		replace groups2 = 6 if country == 804 & age >46 & duplicate == 0
		replace groups2 = 7 if country == 643 & age <47
		replace groups2 = 8 if country == 643 & age >46
			label variable groups2 "Comparison by generation"
			label define lgroups2 1"Old EU <47" 2 "Old EU >46" 3"New EU <47" 4"New EU >46" 5"Ukraine <47" 6 "Ukraine >46" 7"Russia <47" 8 "Russia >46"
			label values groups2 lgroups2
		
	
		gen cult_zone = 1 
		replace cult_zone = 2 if country == 40 | country == 250 |  country == 380 | country == 620 | country == 724 
		replace cult_zone = 3 if country == 191 | country == 203 |  country == 233 | country == 348 |  country ==  440 |  country ==  616 | country ==  703 | country ==  705
		replace cult_zone = 4 if country == 100 | country == 196 |  country ==  642 | country ==  643 |  country == 804 |  country ==  300
			label variable cult_zone "Culture zone"
			label define lcult_zone 1 "Western Protestant" 2 "Western Catholic" 3 "Western Post-Communist" 4"Orthodox"
			label values cult_zone lcult_zone
			
		gen cult_zone2 = cult_zone
		replace cult_zone2 = 3 if country == 300    /// In this culture zone variable, Greece is in the Western Post-Communist cluster 
			
	
		* saving the data before aggregation by country/group 
		save "$path/data before aggregation.dta", replace
		
		
		
		
		*** Multidimensional scaling analyses ***
		
	* agregating the data used for the MDS analyses 
	collapse independent - gender_job cult_zone cult_zone2, by (country2)
			label values cult_zone lcult_zone
			label values cult_zone2 lcult_zone
	
	* merging with data on population size 
	merge 1:1 country2 using "$path\population.dta", nogen 
	
	
		*  creating the EU-values ndixes 
	
	alpha homosex abortion divorce, gen (freedom)
		label variable freedom "Personal freedom"
	alpha independent obedience parents_proud parents_ill, gen (autonomy)
		label variable autonomy "Individual Autonomy"
	alpha  neigh_race neigh_immig immig_jobs, gen (tolerance)
		label variable tolerance "Ethnic Tolerance"
	alpha just_benefit just_tax just_bribe, gen (honesty)
		label variable honesty "Civic Honesty"
	alpha gender*, gen (gender) casewise
		label variable gender "Gender Equality"
	alpha dem_leader dem_army dem_system, gen (democracy)
		label variable democracy "Liberal Democracy"
	
	alpha freedom autonomy tolerance honesty gender democracy, gen (EU_values)	
		label variable EU_values "EU-Values"
		
			
	* Multidimensional scaling analysis 
		mds freedom autonomy tolerance honesty gender democracy, id(country2) method(modern) measure(L2)
		predict d1 d2, config // save the coordinates 
			drop if d1 ==. 	
			gen d1_2 = d1*(-1)  // reverse the coordinates for Western countries to be on the left 
			drop d1
			rename d1_2 d1
		keep country2 d1 d2 population cult_zone cult_zone2
	export excel "C:\Users\akali\Desktop\Data viz with R\Ukraine values\Data\MDS1", firstrow(variables) replace 
	
	
		
		
		* analysis with NUTS1 regions 
	
	* oepning the data before aggregation as we need to agregate it for the new units of analysis 
	use "$path/data before aggregation.dta", clear
	
	
	* agregating for the NUTS1-level analysis 
	collapse independent - gender_job if country == 643 | country == 804 | country == 276 | country == 616, by (nuts1 country)
	
	
		*  creating the EU-values ndixes 
	
	alpha homosex abortion divorce, gen (freedom)
		label variable freedom "Personal freedom"
	alpha independent obedience parents_proud parents_ill, gen (autonomy)
		label variable autonomy "Individual Autonomy"
	alpha  neigh_race neigh_immig immig_jobs, gen (tolerance)
		label variable tolerance "Ethnic Tolerance"
	alpha just_benefit just_tax just_bribe, gen (honesty)
		label variable honesty "Civic Honesty"
	alpha gender*, gen (gender) casewise
		label variable gender "Gender Equality"
	alpha dem_leader dem_army dem_system, gen (democracy)
		label variable democracy "Liberal Democracy"
	
	alpha freedom autonomy tolerance honesty gender democracy, gen (EU_values)	
		label variable EU_values "EU-Values"
		
		
		* MDS analysis for NUTS1 - Russia, Ukraine, Poland and Germany
		drop if nuts1 == "-3" // Ukraine has no data on nuts in one of the surveys 
		
		mds freedom autonomy tolerance honesty gender democracy, id(nuts1) method(modern) measure(L2)
		predict d1 d2, config // save the coordinates 
			drop if d1 ==. 	
			gen d1_2 = d1*(-1)  // reverse the coordinates for Western countries to be on the left 
			drop d1
			rename d1_2 d1
		keep nuts1  d1 d2 country 
	export excel "C:\Users\akali\Desktop\Data viz with R\Ukraine values\Data\MDS2", firstrow(variables) replace
	

						
			
			
			
	    *** Regression analyses *** 
					
	* oepning the data before aggregation as we need to agregate it for the new units of analysis 
	use "$path/data before aggregation.dta", clear
	
	
		*  creating the EU-values ndixes at the individual-level 
	
	alpha homosex abortion divorce, gen (freedom)
		label variable freedom "Personal freedom"
	alpha independent obedience parents_proud parents_ill, gen (autonomy)
		label variable autonomy "Individual Autonomy"
	alpha  neigh_race neigh_immig immig_jobs, gen (tolerance)
		label variable tolerance "Ethnic Tolerance"
	alpha just_benefit just_tax just_bribe, gen (honesty)
		label variable honesty "Civic Honesty"
	alpha gender*, gen (gender) casewise
		label variable gender "Gender Equality"
	alpha dem_leader dem_army dem_system, gen (democracy)
		label variable democracy "Liberal Democracy"
	
	alpha freedom autonomy tolerance honesty gender democracy, gen (EU_values)	
		label variable EU_values "EU-Values"
		
		
		*  Analysis by country/group (Figure 3 - to be created in R)
		foreach var of varlist freedom autonomy tolerance honesty gender democracy EU_values {
		reg `var' i.groups [pweight=equal_weights1000]
		margins groups, post 
		est store `var'_margins
		}	
		
		
		* Exporting results into a table 
		esttab freedom_margins autonomy_margins tolerance_margins honesty_margins gender_margins democracy_margins EU_values_margins using "$path\margins.rtf", b(1) ci(1)  label  replace   compress nostar mtitles("Personal Freedom" "Individual Autonomy" "Ethnic Tolerance" "Civic Honesty" "Gender Equality""Liberal Democracy" "EU-Values")
	
		* exporting the data to R 
		saveold "SPECIFY YOUR FOLDER\Ukraine by region.dta", version (12) replace
	
	
	
	
		
		*  Analysis by country/groups and generations (Figure 4 - to be created in R)
		foreach var of varlist freedom autonomy tolerance honesty gender democracy EU_values {
		reg `var' i.groups2 [pweight=equal_weights1000]
		margins groups2, post 
		est store `var'_marg_gen
		}	
	
		* Exporting results into a table 
		esttab freedom_marg_gen autonomy_marg_gen tolerance_marg_gen honesty_marg_gen gender_marg_gen democracy_marg_gen EU_values_marg_gen using "$path\margins by generation.rtf", b(1) ci(1)  label  replace   compress nostar mtitles("Personal Freedom" "Individual Autonomy" "Ethnic Tolerance" "Civic Honesty" "Gender Equality""Liberal Democracy" "EU-Values")
	
		
		* exporting the data to R 
		saveold "SPECIFY YOUR FOLDER\Ukraine by generation.dta", version (12) replace

		
		
				
	
		****  Analysis of Ukraine (Table 1) 
		keep if country == 804 & duplicate == 0
			
		reg EU_values i.region_UKR i.study
			est store region
		reg EU_values i.region_UKR i.religion i.language_inter i.study
			est store heritage 
		reg EU_values i.region_UKR sex age i.education3 income i.city_size i.empstatus  i.study
			est store demography
		reg EU_values i.region_UKR sex age i.empstatus i.education3 income i.city_size i.religion i.language_inter i.study
			est store all
		
		
		* Exporting the results into a table 
		esttab region heritage demography all using "$path\Ukraine.rtf", b(2) se(2)  label  replace   compress 	wide 
	
	
		*** analyses for all the domains (Appendix Figures A3-A8)
		foreach var of varlist freedom autonomy tolerance honesty gender democracy {
		reg `var' i.region_UKR i.study
			est store `var'region
		reg `var' i.region_UKR i.religion i.language_inter i.study
			est store `var'heritage 
		reg `var' i.region_UKR sex age i.education3 income i.city_size i.empstatus  i.study
			est store `var'demography
		reg `var' i.region_UKR sex age i.empstatus i.education3 income i.city_size i.religion i.language_inter i.study
			est store `var'all
		
		esttab `var'region `var'heritage `var'demography `var'all using `var'Ukraine.rtf, b(2) se(2)  label  replace   compress wide 
		}
		

* end of do-file 
	
	
	
	
	
	
	
	
	
	
	

