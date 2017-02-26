# #######################################################################
# File-Name:  mapping_code.R
# Version:  1
# Date:  02/23/17
# Author:  amp5
# Purpose:  massage data into format for mapping in QGIS
# Input Files:  2015_stopandfrisk_CLEAN.csv
# Output Files: 2015_stopandfrisk_CLEAN_w_counties.csv , 2015_SAF_county.csv, bronx.csv
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


## For now only looking at coords, county and pforce

map_df <- df[,c('xcoord', 'ycoord', 'county', 'geoid', 'pforce')]


### need to sum pforce for each county
map_sum <- aggregate(pforce ~ county, data=df, FUN=sum)

map_sum$geoid <- c(36005, 36047, 36061, 36081, 36085)

map_sum
write.csv(map_sum, '2015_SAF_county.csv')


## now look at bronx:

  
bronx <- filter(df, county %in% c('Bronx'))
write.csv(bronx, 'bronx.csv')


# summing pforce for each unique location
bronx_p <- bronx[,c('xcoord', 'ycoord', 'county', 'geoid', 'pforce')]
# some reason lost 66 pforce in next var.... there are NA xcoord and ycoord in above var
# aggregate doesn't count this
# TODO: go back and remove any NA coords rows (~172ish)
bronx_unq_p <- aggregate(pforce ~ xcoord + ycoord, data = bronx_p, FUN = sum)

nrow(bronx_unq_p)
# 2220 unique locations for SaF

bronx_pf_unq <- filter(bronx_unq_p, pforce > 0)
nrow(bronx_pf_unq)
# 1199 unique locatiosn with some police force

(sum(bronx_pf_unq$pforce))

write.csv(bronx_pf_unq, 'bronx_pf_unq.csv')
