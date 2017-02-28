police <- read.csv('/Users/zachheinemann/Downloads/2015_sqf_csv.csv', header = TRUE, stringsAsFactors = FALSE)
police$sex[police$sex == "Z"] <- NA
police$sex[police$sex == "M"] <- "Male"
police$sex[police$sex == "F"] <- "Female"

police$race[police$race == "A"] <- "Asian / Pacific Islander"
police$race[police$race == "B"] <- "Black"
police$race[police$race == "I"] <- "American Indian / Alaskan Native"
police$race[police$race == "P"] <- "Black"
police$race[police$race == "Q"] <- "White - Hispanic"
police$race[police$race == "U"] <- NA
police$race[police$race == "W"] <- "White"
police$race[police$race == "Z"] <- NA

police$pforce[police$pf_wall == 1 | police$pf_grnd == 1 | police$pf_hands == 1 | police$pf_drwep == 1 | police$pf_ptwep == 1 | police$pf_baton == 1 | police$pf_hcuff == 1 | police$pf_pepsp == 1 | police$pf_other == 1] <- 1
police$pforce[is.na(police$pforce) == TRUE] <- 0

police$build[police$build == "H"] <- "Heavy"
police$build[police$build == "M"] <- "Medium"
police$build[police$build == "T"] <- "Thin"
police$build[police$build == "U"] <- "Muscular"
police$build[police$build == "Z"] <- NA

police$city[police$city == "BRONX"] <- "Bronx"
police$city[police$city == "BROOKLYN"] <- "Brooklyn"
police$city[police$city == "MANHATTAN"] <- "Manhattan"
police$city[police$city == "QUEENS"] <- "Queens"
police$city[police$city == "STATEN IS"] <- "Staten Island"

police$armed[police$pistol == 1 | police$riflshot == 1 | police$asltweap == 1 | police$knifcuti == 1 | police$machgun == 1 | police$othrweap == 1] <- 1
police$armed[is.na(police$armed) == TRUE] <- 0

police$inout[police$inout == "I"] <- "Inside"
police$inout[police$inout == "O"] <- "Outside"

write.csv(police, file = "/Users/zachheinemann/Documents/2015_stopandfrisk_CLEAN.csv", row.names = FALSE)
library(gmodels)

police$race <- as.factor(police$race)
police <- within(police, race <- relevel(race, ref = 4))
summary(fit <- glm(pforce ~ race + sex, data = police, family = "binomial"))
summary(fit <- glm(arstmade ~ race + sex, data = police, family = "binomial"))
summary(fit <- glm(explnstp ~ race + sex, data = police, family = "binomial"))
summary(fit <- glm(frisked ~ race + sex, data = police, family = "binomial"))

summary(fit <- glm(pforce ~ race + sex + build + city + ac_incid + ac_time + armed + offunif + inout, data = police, family = "binomial"))
summary(fit <- glm(arstmade ~ race + sex + build + city + ac_incid + ac_time + armed + offunif + inout, data = police, family = "binomial"))
summary(fit <- glm(frisked ~ race + sex + build + city + ac_incid + ac_time + armed + offunif + inout, data = police, family = "binomial"))

summary(fit <- glm(frisked ~ race * sex + build + city + ac_incid + ac_time + armed + offunif + inout, data = police, family = "binomial"))
