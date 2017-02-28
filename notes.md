**Purpose:** The purpose of this file is for the team to document what they have done so far and what important information should be noted. 


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

<p align="center">
  <b>02/28/17 - File Structure - Stephanie </b>
</p>

I organized our files as such:

**1) Backgrounf folder**: Zach's NYPD project and any other research we have and want to save can go into this folder.  Link:  https://github.com/amp5/QMSS_G5069_Applied_D_S/tree/master/Background

**2) Code folder**:  All CURRENT code is saved here:  https://github.com/amp5/QMSS_G5069_Applied_D_S/tree/master/Code and within this folder, there is a subfolder for all **outdated code** - please move outdated code files from the **Code** to this folder when appropriate: https://github.com/amp5/QMSS_G5069_Applied_D_S/tree/master/Code/Outdated%20Code

**3) Data/Code Book** folder: The code book is here as well as 2 subfolders:

  **3a) Cleaned**: All cleaned data
  
  **3b) Raw/Outdated**: All datasets that we aren't using anymore are saved here - please move outdated datasets frome the **Cleaned** folder to this folder when appropriate.

