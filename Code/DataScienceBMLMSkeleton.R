#############################################################
# File-Name:  DataScienceBMLMSkeleton.R
# Version: 1
# Date: 04/25/17
# Author: Zachary Heinemann 
# Purpose: Build a bayesian muilt-level model
# Input Files: "2015_stopandfrisk_CLEAN_w_counties.csv"
# Output Files: None yet
# Data Output: none  
# Previous files: None
# Dependencies: None
# Required by: Data Analysis Final Project
# Status: In progress 
# Machine: MacBook 
# R version 3.3.3
#############################################################

##::::::::::::::::: Set path:

# stop_frisk <- read.csv('/Users/zachheinemann/GitHub/QMSS_G5069_Applied_D_S/Data+Code Book/Cleaned/2015_stopandfrisk_CLEAN_w_counties.csv') ## zach's path

stop_frisk <- read.csv("/Users/StephanieLangeland/Desktop/Columbia/Applied Data Science/Git/QMSS_G5069_Applied_D_S/Data+Code Book/Cleaned/2015_stopandfrisk_CLEAN_w_counties.csv") ## stephanie's path

##::::::::::::::::: Prepare the data:
stop_frisk$datestop <- as.character(stop_frisk$datestop) 

for(i in 1:21747){
  if(nchar(stop_frisk$datestop[i]) == 3){
    if(substr(stop_frisk$datestop[i], 1, 1) == "1") {
      stop_frisk$datestop[i] <- paste0("-01-", substring(stop_frisk$datestop[i], 2))
    } else if (substr(stop_frisk$datestop[i], 1, 1) == "2") {
      stop_frisk$datestop[i] <- paste0("-02-", substring(stop_frisk$datestop[i],2))
    } else if (substr(stop_frisk$datestop[i], 1 , 1) == "3") {
      stop_frisk$datestop[i] <- paste0("-03-", substring(stop_frisk$datestop[i], 2))
    } else if (substr(stop_frisk$datestop[i], 1, 1) == "4") {
      stop_frisk$datestop[i] <- paste0("-04-", substring(stop_frisk$datestop[i],  2))
    } else if (substr(stop_frisk$datestop[i], 1, 1) == "5") {
      stop_frisk$datestop[i] <- paste0("-05-", substring(stop_frisk$datestop[i], 2))
    } else if (substr(stop_frisk$datestop[i], 1, 1) == "6") {
      stop_frisk$datestop[i] <- paste0("-06-", substring(stop_frisk$datestop[i], 2))
    } else if (substr(stop_frisk$datestop[i], 1, 1) == "7") {
      stop_frisk$datestop[i] <- paste0("-07-", substring(stop_frisk$datestop[i], 2))
    } else if (substr(stop_frisk$datestop[i], 1, 1) == "8") {
      stop_frisk$datestop[i] <- paste0("-08-", substring(stop_frisk$datestop[i], 2))
    } else if (substr(stop_frisk$datestop[i], 1, 1) == "9") {
      stop_frisk$datestop[i] <- paste0("-09-", substring(stop_frisk$datestop[i], 2))
    } 
  } else if (nchar(stop_frisk$datestop[i]) == 4) {
    if(substr(stop_frisk$datestop[i], 1, 2) == "11") {
      stop_frisk$datestop[i] <- paste0("-11-", substring(stop_frisk$datestop[i], 3))
    } else if (substr(stop_frisk$datestop[i], 1, 2) == "12") {
      stop_frisk$datestop[i] <- paste0("-12-", substring(stop_frisk$datestop[i], 3))
    } else if (substr(stop_frisk$datestop[i], 1, 2) == "10") {
      stop_frisk$datestop[i] <- paste0("-10-", substring(stop_frisk$datestop[i], 3))
    }
  }
}

stop_frisk$datestop <- paste0("2015", stop_frisk$datestop)

sf_bronx <- stop_frisk[stop_frisk$city == 'Bronx', ]

sf_bronx$race <- as.factor(sf_bronx$race)
sf_bronx <- within(sf_bronx, race <- relevel(race, ref = 4))

sf_bronx$datestop <- as.Date(sf_bronx$datestop)

sf_bronx$build <- as.factor(sf_bronx$build)
sf_bronx$time <- as.numeric(sf_bronx$datestop)
sf_bronx$time <- sf_bronx$time - 16435

library(rethinking)
sf_bronx <- sf_bronx[is.na(sf_bronx$race) == FALSE & is.na(sf_bronx$sex) == FALSE & is.na(sf_bronx$build) == FALSE & is.na(sf_bronx$time) == FALSE, ]
mdata <- list(Force = sf_bronx$pforce, 
              AIAN = (sf_bronx$race == "American Indian / Alaskan Native"), 
              AAPI = (sf_bronx$race == "Asian / Pacific Islander"), 
              Black = (sf_bronx$race == "Black"), 
              Hispanic = (sf_bronx$race == "White - Hispanic"), 
              Female = (sf_bronx$sex == "Female"), 
              Precinct = as.factor(sf_bronx$pct),
              Medium = (sf_bronx$build == "Medium"),
              Muscular = (sf_bronx$build == "Muscular"),
              Thin = (sf_bronx$build == "Thin"),
              Time = sf_bronx$time)

model.geo <- alist(
  Force ~ dbinom(1, p),
  logit(p) <- a_sub[Precinct] + b_aian[Precinct]* AIAN + b_aapi[Precinct] * AAPI + b_black[Precinct] * Black + b_hisp[Precinct] * Hispanic + b_gender[Precinct] * Female + b_medium[Precinct] * Medium + b_muscular[Precinct] * Muscular + b_thin[Precinct] * Thin + b_time[Precinct] * Time,
  ## we would need a b_sub term for every predictor
  
  c(a_sub,b_aian,b_aapi,b_black,b_hisp, b_gender, b_medium, b_muscular, b_thin, b_time)[Precinct] ~ dmvnorm2(c(a,baian,baapi,bblack,bhispanic,bgender,bmedium,bmuscular,bthin,btime),sigma_sub,Rho),
  ## this needs to include a term for each of the model predictors
  
  a ~ dnorm(0,2),
  baian ~ dnorm(0,3),
  baapi ~ dnorm(0,3),
  bblack ~ dnorm(0,3),
  bhispanic ~ dnorm(0,3),
  bgender ~ dnorm(0,3),
  bmedium ~ dnorm(0,3),
  bmuscular ~ dnorm(0,3),
  bthin ~ dnorm(0,3),
  btime ~ dnorm(0,3),
  
  ##needs to be one of these specifications for each of the terms; we can play with priors
  
  sigma_sub ~ dcauchy(0,2),
  Rho ~ dlkjcorr(4)
)

run.model <- map2stan(model.geo,
                      data=mdata, iter=7000, warmup=2000, chains=4,
                      cores=4)
precis(run.model, depth = 2, digits = 5)