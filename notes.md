**Purpose:** The purpose of this file is for the team to document what they have done so far and what important information should be noted. 

<p align="center">
  <b>03/02/17 - Maps by Race - Alexandra </b>
</p>

![](https://cloud.githubusercontent.com/assets/5368361/23539134/04fc55d8-ffa7-11e6-8da8-70a19652c4f7.png)

Above looks at the amount of pforce used throughout the Bronx by race. Where race was NA the row was removed from this graph. Also the counts for each race is included next to the map. The legend and dot size might be a little confusing since different gradients of red represent different numbers for each race but hopefully the legend and count next to the maps will help alleviate confusion. Natural breaks were used again for this instead of equal or quantile.  

- [ ] Show distribution of pforce for all bronx as justification for natural breaks....
- [ ]Next map to make - GWR with pf vs black or not - look for spatial clusters @Alexandra

<p align="center">
  <b>03/01/17 - Update on maps - Alexandra </b>
</p>

**Block Join Acheived!**

![](https://cloud.githubusercontent.com/assets/5368361/23479203/b5356e7e-fe91-11e6-81af-eb83fce38b20.png)
This is the aggregation of police force count by block in the Bronx. It uses Natural breaks (Jenks). I think this might be better because it shows the distribution of the pforce by block level.


![](https://cloud.githubusercontent.com/assets/5368361/23479179/a3bc8c40-fe91-11e6-85de-baed11672064.png)
This one is displaying the same information but it uses an equal distribution. However this one might be more PC by using equal distr. 

![](https://cloud.githubusercontent.com/assets/5368361/23479393/4dcfbc02-fe92-11e6-8060-7a345e130e6b.png)
This one was not used because it is quantile distribution. It makes things look worse than they are. 


**To Do Next**
- [ ] redo first 3 maps below to exclude rows with NA xcoords and ycoords. @alexandra
- [ ] identify other vars in data that would be useful to compare with pforce data on map and in time series analysis @team
- [ ] calculate the GWR and identify significant clusters @alexandra
- [ ] work on time series analysis @zach
- [ ] identify whats are on blocks (top 10 pforce points) @stephanie / @brandon
- [x] look at who is stopped black vs white vs latinx compared to pforce. must make dummy vars @alexandra

<p align="center">
  <b>02/28/17 - File Structure - Stephanie </b>
</p>

I organized our files as such:

**1) Background folder**: Zach's NYPD project and any other research we have and want to save goes into this folder:  https://github.com/amp5/QMSS_G5069_Applied_D_S/tree/master/Background

**2) Code folder**:  All current/up-to-date/relevant code is saved here:  https://github.com/amp5/QMSS_G5069_Applied_D_S/tree/master/Code and within this folder, there is a subfolder for all **outdated code** - please move outdated code files from the **Code** folder to this subfolder when appropriate: https://github.com/amp5/QMSS_G5069_Applied_D_S/tree/master/Code/Outdated%20Code

**3) Data/Code Book** folder: The code book is here (https://github.com/amp5/QMSS_G5069_Applied_D_S/tree/master/Data:Code%20Book) as well as 2 subfolders:

  **3a) Cleaned**: All cleaned datasets that we are currently using: https://github.com/amp5/QMSS_G5069_Applied_D_S/tree/master/Data:Code%20Book/Cleaned
  
  **3b) Raw/Outdated**: All datasets that we aren't using anymore are saved here - please move outdated datasets from the **Cleaned** folder to this folder when appropriate: https://github.com/amp5/QMSS_G5069_Applied_D_S/tree/master/Data:Code%20Book/Raw:Outdated

**4) Reports folder**: All of our written assignments are saved here e.g., proposal (one pager).  Going forward, we'll save our final presentation and paper here as well: https://github.com/amp5/QMSS_G5069_Applied_D_S/tree/master/Reports

<p align="center">
  <b> Moved from the README file </b>
</p>

**Additional Resources:** 

http://jlegewie.com/files/Legewie-2016-Racial-Profiling-and-Use-of-Force-in-Police-Stops.pdf

http://www1.nyc.gov/site/planning/data-maps/open-data/districts-download-metadata.page

<p align="center">
  <b>2/25/17 - Mapped data - Alexandra </b>
</p>

First the most up-to-date full and cleaned data set is *'2015_stopandfrisk_CLEAN_w_counties.csv'*
The data set *'2015_stopandfrisk_CLEAN.csv'* actually had rows where there were no x and y coordinates.

The original csv had 22563 rows, after all rows w/ NA in xcoord removed, the new file has 21747 rows.

For a focus on the Bronx area please use *'bronx_pf_unq.csv'*

4 maps have been created:

**Data Exploration So Far**

![](https://cloud.githubusercontent.com/assets/5368361/23278155/88a070fa-f9de-11e6-892c-aca5b1f3532e.png)

![](https://cloud.githubusercontent.com/assets/5368361/23278160/8c1cff8c-f9de-11e6-860c-62f927ef516d.png)

![](https://cloud.githubusercontent.com/assets/5368361/23278157/8a23bf36-f9de-11e6-9044-dc68883187a5.png)

![](https://cloud.githubusercontent.com/assets/5368361/23336176/e3b5d602-fb95-11e6-97b0-82cd891adb26.png)


The problem I'm running into now is merging the csv file with a block level shapefile. 
Until I can figure out how to do so I can't run any spatial regression tests. 

I think the next step should be to work on our models focusing on the Bronx as that has the highest amounts of police force.
Also I think something I need to redo will be the first 3 maps because they were created with the original csv file which had
rows with NA xcoords and ycoords. Thus the sums are slightly off. It should make too much of a difference. But just to be safe. 
