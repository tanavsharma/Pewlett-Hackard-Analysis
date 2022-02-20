# Pewlett-Hackard-Analysis

## Overview
We will be working with Pewlett Hackard to determine the number of retiring employees and which ones are eligible to participate in the mentroship program. We will then summarize our findings in this report and discuss how the company can prepare to respond to the "silver tsunami". 
## Results

In our analysis we first extracted **The Number of Retiring Employees by Title** from the data set and put this extracted information into a new table called, **retirement_titles**.  Here is an output of that result:

<img src="/Screenshots/retirement_titles_png.png" alt="pyberData_table_summary" width=750><br>

### Major Point 1:
As we can already see that some employees are showing up twice. For example, from the image abovee line numbers 2,3,4,5,7,8,9,11 and 12 are repating employees. This is because these employee has switched roles 1 or more times through out their carrers in the company.

### Major Point 2:
We have to get data that only shows the most recent active role of the emplpyee. As we can see the to date for some employees goes till the year 9999. Which implies that thats their current active role. After re-writing the query, here is the result:

<img src="/Screenshots/unique_titles.png" alt="pyberData_table_summary" width=600><br>
### Major Point 3:
From our image above we can now see that its only showing employees in their most recent active role. Its important to note that we are looking at active employees only, so if any employee who has left the company or does not have the `to_date` = to `9999-01-01` will not be displayed

### Major Point 4:
Anotheer thing we can look at is how many employees from each department will be retiring. This will help us visulaize which departments will be impacted from greatest to least. Here is what that output looks like:<br><br>
<img src="/Screenshots/retiring_titles.png" alt="pyberData_table_summary" width=360><br>

## Summary 
**How many roles will need to be filled as the "silver tsunami" begins to make an impact?** 
72,458 roles would need to be filled
We just need to sum up the count of employess from each department. Here is a breakdown of that number:
```
  25916	Senior Engineer
+ 24926	Senior Staff
+ 9285	Engineer
+ 7636	Staff
+ 3603	Technique Leader
+ 1090	Assistant Engineer
+ 2	Manager
---------------------------
= 72,458 
---------------------------
```

**Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?**
Lets find the number of employees in the mentroship program by running this query on the table:
```
SELECT COUNT(emp_no) FROM mentorship_eligibilty;
```
We get a result of `1549`

With that number we can safely determine that we do not have enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees.



