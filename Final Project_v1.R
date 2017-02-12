# #######################################################################
# File-Name:  Final Project_v1
# Version:  1
# Date:  02/11/17
# Author:  Stephanie Langeland
# Purpose:  Explore data
# Input Files: ? 
# Output Files: ?
# Data Output: ?
# Previous files: None
# Dependencies: ?
# Required by: ?
# Status: In progress
# Machine:  Stephanie's 2011 MacBook Pro
# #######################################################################

setwd("/Users/StephanieLangeland/Desktop/Columbia/Applied Data Science/Git/QMSS_G5069_Applied_D_S/data/raw")
d2003 <- read.csv("/Users/StephanieLangeland/Desktop/Columbia/Applied Data Science/Git/QMSS_G5069_Applied_D_S/data/raw/2003.csv")
d2004 <- read.csv("/Users/StephanieLangeland/Desktop/Columbia/Applied Data Science/Git/QMSS_G5069_Applied_D_S/data/raw/2004.csv")
d2005 <- read.csv("/Users/StephanieLangeland/Desktop/Columbia/Applied Data Science/Git/QMSS_G5069_Applied_D_S/data/raw/2005.csv")
d2006 <- read.csv("/Users/StephanieLangeland/Desktop/Columbia/Applied Data Science/Git/QMSS_G5069_Applied_D_S/data/raw/2006.csv")
d2007 <- read.csv("/Users/StephanieLangeland/Desktop/Columbia/Applied Data Science/Git/QMSS_G5069_Applied_D_S/data/raw/2007.csv")
d2008 <- read.csv("/Users/StephanieLangeland/Desktop/Columbia/Applied Data Science/Git/QMSS_G5069_Applied_D_S/data/raw/2008.csv")
d2009 <- read.csv("/Users/StephanieLangeland/Desktop/Columbia/Applied Data Science/Git/QMSS_G5069_Applied_D_S/data/raw/2009.csv")
d2010 <- read.csv("/Users/StephanieLangeland/Desktop/Columbia/Applied Data Science/Git/QMSS_G5069_Applied_D_S/data/raw/2010.csv")
d2011 <- read.csv("/Users/StephanieLangeland/Desktop/Columbia/Applied Data Science/Git/QMSS_G5069_Applied_D_S/data/raw/2011.csv")
d2012 <- read.csv("/Users/StephanieLangeland/Desktop/Columbia/Applied Data Science/Git/QMSS_G5069_Applied_D_S/data/raw/2012.csv")
d2013 <- read.csv("/Users/StephanieLangeland/Desktop/Columbia/Applied Data Science/Git/QMSS_G5069_Applied_D_S/data/raw/2013.csv")
d2014 <- read.csv("/Users/StephanieLangeland/Desktop/Columbia/Applied Data Science/Git/QMSS_G5069_Applied_D_S/data/raw/2014.csv")
d2015 <- read.csv("/Users/StephanieLangeland/Desktop/Columbia/Applied Data Science/Git/QMSS_G5069_Applied_D_S/data/raw/2015_sqf_csv.csv")
#^is there a way that I can write the code so that it works for anyone's working directory, not just mine?

#see if all of the variables (colnames) are the same in each file, if so, combine into one master dataset:
my_func <- function(x, y) {
  for(i in names(x)) {
    if(!(i %in% colnames(y))) {
      print('Warning: column names are NOT the same')
      break
    }
    else if(i == tail(colnames(y), n = 1)) {
      print('Column names are identical')
    }
  }
}

my_func(d2003, d2004) #function seems to work
mer <- matrix(nrow = c(2, 3),
              ncol = c(4, 8)) 
colnames(mer)
my_func(d2003, mer) #verified that my_func works

my_func(d2003, d2004) #colnames are the same
my_func(d2004, d2005) #colnames are the same
my_func(d2005, d2006) #colnames are NOT the same
my_func(d2005, d2007) #colnames are the same so d2006 is the problem
#arrange columns in d2006 to match column order in d2005:

my_func(d2006, d2007) #colnames are NOT the same - the above code should fix this after the columns are rearranged
my_func(d2007, d2008) #colnames are the same
my_func(d2008, d2009) #colnames are the same
my_func(d2009, d2010) #colnames are the same
my_func(d2010, d2011) #colnames are the same
my_func(d2011, d2012) #colnames are the same
my_func(d2012, d2013) #colnames are NOT the same
#Column order changed in 2013 - need to change the column order for 2013 - 2015 to the same column order as 2003-2012:

my_func(d2013, d2014) #colnames are the same
my_func(d2014, d2015) #colnames are the same

#Next step - combine all datasets into one master dataset:

