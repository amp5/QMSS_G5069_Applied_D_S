# #######################################################################
# File-Name:  mapping_w_precint.R
# Version:  1
# Date:  02/23/17
# Author:  amp5
# Purpose:  adding in precinct data
# Input Files:  bronx_agg_pf.csv, cleaned_2015_crime_data.csv
# Output Files: 
# Previous files: mapping_code.R
# Dependencies: ?
# Status: In progress
# Machine:  amp5's MacBook Pro
# #######################################################################
library(tidyverse)
library(rpart)
library(rpart.plot)
library(RColorBrewer)
library(randomForest)
library(rattle)

path <- "/Users/alexandraplassaras/Desktop/Spring_2017/NY_Crime_2015"
setwd(path)

# bronx_agg_pf.csv
bronx_agg_pf <- read.csv(file.choose())
# 2015_stopandfrisk_CLEAN_w_counties.csv
s_a_f <- read.csv(file.choose())

# cleaned_2015_crime_data.csv
p_data <- read.csv(file.choose())


# Code --------------------------------------------------------------------


# Random Forest -----------------------------------------------------------
bronx_d <- filter(s_a_f, county == "Bronx")



pf_data <- bronx_d[c("pforce", "rf_furt", "rf_knowl", "rf_verbl", "rf_rfcmp",
                     "rf_vcact", "rf_attir", "rf_othsw", "rf_vcrim", "othrweap", "machgun", "knifcuti",
                     "asltweap", "riflshot", "pistol", "adtlrept", "contrabn", "searched", "frisked",
                     "weight", "age", "race", "sex", "rf_bulg", "haircolr", "eyecolor", "build", "pct")]

fit <- rpart(pforce ~ rf_furt + rf_knowl + rf_verbl + rf_rfcmp + rf_vcact + rf_attir + rf_othsw + rf_vcrim + 
             othrweap + machgun + knifcuti + asltweap + riflshot + pistol + adtlrept + contrabn + searched + frisked +
             weight + age + race + sex + rf_bulg + build + pct, 
             data = pf_data, 
             method = "class")



fancyRpartPlot(fit)


prop.table(table(pf_data$pforce))
#       0         1 
# 0.5626364 0.4373636 


set.seed(415)

# sex, race and build all have NAs
# taking out sex since regardless of gender we want to know, weight can be a proxy for build and visually 
# we have already seen that race is important

fit2 <- randomForest(as.factor(pforce) ~ rf_furt + rf_knowl + rf_verbl + rf_rfcmp + rf_vcact + rf_attir + 
                       rf_othsw + rf_vcrim + othrweap + machgun + knifcuti + asltweap + riflshot + pistol + 
                       adtlrept + contrabn + searched + frisked + weight + age  + rf_bulg + pct, 
                        data = pf_data, 
                        importance=TRUE, 
                        ntree=100)

varImpPlot(fit2)

# Mapping Precinct data ---------------------------------------------------
precincts <- unique(pf_data$pct)


bronx_pct <- subset(p_data, pct == "40" | pct =="41" | pct =="42" | pct =="43"
                    | pct =="44" | pct =="45" | pct =="46" | pct =="47" | pct =="48"
                    | pct =="49" | pct =="50" | pct =="52")

str(bronx_pct)

pct_crimes <- aggregate(crimes_count ~ pct + type, data=bronx_pct, FUN=sum)

pct_crimes_1 <- filter(pct_crimes, type == "misdemeanor_offenses")
pct_crimes_2 <- filter(pct_crimes, type == "non_seven_major_felony_offenses")
pct_crimes_3 <- filter(pct_crimes, type == "violation_offenses")


pct_crimes_new <- merge(pct_crimes_1, pct_crimes_2, by = "pct", all = TRUE)
pct_crimes_new <- merge(pct_crimes_new, pct_crimes_3, by = "pct", all = TRUE)

names(pct_crimes_new) <-  c("pct", "misdemeanor_offenses", "m_o_count", "non_seven_major_felony_offenses",
                            "nsm_fo_count", "violation_offenses", "v_o_count")

# Output ------------------------------------------------------------------
write.csv(pct_crimes_new, 'Data:Code Book/Cleaned/bronx_pct_crimes.csv')



