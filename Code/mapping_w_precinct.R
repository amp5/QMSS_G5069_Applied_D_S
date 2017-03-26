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


# Output ------------------------------------------------------------------


