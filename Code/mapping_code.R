# #######################################################################
# File-Name:  mapping_code.R
# Version:  1
# Date:  02/23/17
# Author:  amp5
# Purpose:  massage data into format for mapping in QGIS
# Input Files:  2015_stopandfrisk_CLEAN.csv
# Output Files: 2015_stopandfrisk_CLEAN_w_counties.csv , 2015_SAF_county.csv, bronx.csv, bronx_agg_pf.csv
# Data Output: ?
# Previous files: Final Project_v1.R
# Dependencies: ?
# Required by: QGIS
# Status: In progress
# Machine:  amp5's MacBook Pro
# #######################################################################


library(tidyverse)

df <- read.csv('data/2015_stopandfrisk_CLEAN.csv')

# orig df had 22563 rows, after all rows w/ NA in xcoord removed, 
# df has 21747
nrow(df)

df <- filter(df, !is.na(xcoord))

# orig df had 22563 rows, after all rows w/ NA in xcoord removed, 
# df has 21747

df$county <- ifelse(df$city == 'Manhattan', 'New York', 
                    ifelse(df$city == "Bronx", 'Bronx', 
                           ifelse(df$city == "Brooklyn", 'Kings', 
                                  ifelse(df$city == "Queens", 'Queens', 
                                         ifelse(df$city == "Staten Island", 'Richmond', 1)))))


df$geoid <- ifelse(df$city == 'Manhattan', 36061, 
                    ifelse(df$city == "Bronx", 36005, 
                           ifelse(df$city == "Brooklyn", 36047, 
                                  ifelse(df$city == "Queens", 36081, 
                                         ifelse(df$city == "Staten Island", 36085, 1)))))



write.csv(df, '2015_stopandfrisk_CLEAN_w_counties.csv')

data_all <- read_csv("/Users/alexandraplassaras/Desktop/Spring_2017/QMSS_G5069/QMSS_G5069_Applied_D_S-master/data/2015_stopandfrisk_CLEAN_w_counties.csv")


## For now only looking at coords, county and pforce

map_df <- data_all[,c('xcoord', 'ycoord', 'county', 'geoid', 'pforce', 'race', 
                      'rf_furt', 'rf_bulg', 'rf_knowl', 'rf_verbl', 'rf_rfcmp',
                      'rf_vcact', 'rf_attir', 'rf_othsw', 'rf_vcrim')]


### need to sum pforce for each county
map_sum <- aggregate(pforce ~ county, data=data_all, FUN=sum)

map_sum$geoid <- c(36005, 36047, 36061, 36081, 36085)

map_sum
write.csv(map_sum, '2015_SAF_county.csv')


## now look at bronx:

  
bronx <- filter(data_all, county %in% c('Bronx'))
write.csv(bronx, 'bronx.csv')


# summing pforce for each unique location
bronx_p <- bronx[,c('xcoord', 'ycoord', 'county', 'geoid', 'pforce', 'race', 
                    'rf_furt', 'rf_bulg', 'rf_knowl', 'rf_verbl', 'rf_rfcmp',
                    'rf_vcact', 'rf_attir', 'rf_othsw', 'rf_vcrim')]

bronx_p_r <- within(bronx_p, {
  blck <-  ifelse(race == "Black", 1, 0)
  wht <- ifelse(race == "White" , 1, 0)
  wht_h <- ifelse(race == "White - Hispanic", 1, 0)
  ntv <-  ifelse(race == "American Indian / Alaskan Native", 1, 0)
  azn <- ifelse(race == "Asian / Pacific Islander", 1, 0)
})
  
  
  


# some reason lost 66 pforce in next var.... there are NA xcoord and ycoord in above var
# aggregate doesn't count this
# TODO: go back and remove any NA coords rows (~172ish)


bronx_pf_r <- bronx_p_r[complete.cases(bronx_p_r),]

write.csv(bronx_pf_r, 'data/bronx_pf_r.csv')


bronx_pf_r_smll <- bronx_pf_r[, c( "xcoord", "ycoord", "pforce", "race",
                                      "azn",  "ntv",  "wht_h",  "wht",  "blck"  )]

bronx_pf_blck <- filter(bronx_pf_r_smll, blck %in% 1)
bronx_pf_blck <- aggregate(pforce ~ xcoord + ycoord, data = bronx_pf_blck, FUN = sum)
bronx_pf_blck <- bronx_pf_blck[bronx_pf_blck$pforce > 0,]

bronx_pf_azn <- filter(bronx_pf_r_smll, azn %in% 1)
bronx_pf_azn <- aggregate(pforce ~ xcoord + ycoord, data = bronx_pf_azn, FUN = sum)
bronx_pf_azn <- bronx_pf_azn[bronx_pf_azn$pforce > 0,]

bronx_pf_wht <- filter(bronx_pf_r_smll, wht %in% 1)
bronx_pf_wht <- aggregate(pforce ~ xcoord + ycoord, data = bronx_pf_wht, FUN = sum)
bronx_pf_wht <- bronx_pf_wht[bronx_pf_wht$pforce > 0,]

bronx_pf_wht_h <- filter(bronx_pf_r_smll, wht_h %in% 1)
bronx_pf_wht_h <- aggregate(pforce ~ xcoord + ycoord, data = bronx_pf_wht_h, FUN = sum)
bronx_pf_wht_h <- bronx_pf_wht_h[bronx_pf_wht_h$pforce > 0,]

bronx_pf_ntv <- filter(bronx_pf_r_smll, ntv %in% 1)
bronx_pf_ntv <- aggregate(pforce ~ xcoord + ycoord, data = bronx_pf_ntv, FUN = sum)
bronx_pf_ntv <- bronx_pf_ntv[bronx_pf_ntv$pforce > 0,]
  

write.csv(bronx_pf_blck, 'data/bronx_pf_blck.csv')
write.csv(bronx_pf_azn, 'data/bronx_pf_azn.csv')
write.csv(bronx_pf_wht, 'data/bronx_pf_wht.csv')
write.csv(bronx_pf_wht_h, 'data/bronx_pf_wht_h.csv')
write.csv(bronx_pf_ntv, 'data/bronx_pf_ntv.csv')



bronx <- filter(data_all, county %in% c('Bronx'))







bronx_unq_p <- aggregate(pforce ~ xcoord + ycoord, data = bronx_p, FUN = sum)


bronx_agg <- aggregate(cbind(pforce, rf_furt, rf_bulg, rf_knowl, rf_verbl, rf_rfcmp,
                    rf_vcact, rf_attir, rf_othsw, rf_vcrim) ~ xcoord + ycoord, data = bronx_p, FUN = sum)

bronx_agg %>%
  nrow()


bronx_agg_pf <-  bronx_agg[bronx_agg$pforce > 0,]



# 2220 unique locations for SaF
# 1199 unique locatiosn with some police force


write.csv(bronx_agg_pf, 'bronx_agg_pf.csv')


### will now count black and white races



bronx_agg_pf <- read.csv('data/bronx_agg_pf.csv')



