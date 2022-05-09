SELECT * FROM dataquest.detailedn;

SELECT * FROM dataquest.dailyc;

## 1. For Each State which district is having highest confirmed cases ?
SELECT State, District, MAX(Confirmed) as Confirmed
FROM dataquest.detailedn 
GROUP BY State 
ORDER BY Confirmed DESC;

## 2. For the Month with highest cases what was “Cured to Confirmed Ratio” of state with highest deaths ?
SELECT Date, SUM(Cured_Discharged_Migrated)/SUM(TotalConfirmedcases) AS Cured_to_Confirmed_Ratio, State, MAX(Death) AS Max_Death
FROM dataquest.dailyc 
GROUP BY MONTH(Date) 
ORDER BY MAX(Death) DESC;

## 3. List top 5 districts in which least number of deaths occurred (greater than zero) ?
SELECT distinct(d.District), dc.Death 
FROM dataquest.detailedn d
JOIN dataquest.dailyc dc on dc.State=d.State
WHERE dc.Death > 0 
ORDER BY dc.Death LIMIT 5;

## 4. Which state had highest percentage of deceased cases?
SELECT State, Deceased * 100.0/ SUM(Deceased) OVER() 'Percentage of Death(%)'
from dataquest.detailedn
group by State 
order by Deceased desc;

## 5. Which Month shows highest number of New Cases (Represent month as Jan, feb not as 1, 2)?
Select Distinct monthname(str_to_date(Date,'%Y/%m/%d')) As Month,  MAX(Newcases) as Newcase
From dataquest.dailyc
group by Month
Order By MAX(Newcases) desc;

## 6. For Each State in which month ratio of cured to confirmed was least (greater than 0) ?
SELECT State, Date, (SUM(Cured_Discharged_Migrated)/SUM(TotalConfirmedcases)) AS Cured_to_Confirm_Ratio 
FROM dataquest.dailyc
WHERE Cured_Discharged_Migrated > 0
GROUP BY State
ORDER BY Cured_to_Confirm_Ratio DESC;

## 7. For each State which District had min Confirmed Delta Cases?
SELECT State, District, min(DeltaConfirmed) as DC
FROM dataquest.detailedn
Group By State
ORDER BY DC asc;

## 8. How Many Deaths Occurred for State codes [“AR”, “CT”,” BR “, “DL”, “KA”,” MH”,“UP”] in the month of May?
SELECT monthname(str_to_date('0000-05-00','%Y-%m-%d')) as Month_of_May, cn.StateCode, cn.State, Count(cn.Deceased) AS Death 
FROM dataquest.dailyc c
JOIN dataquest.detailedn cn ON c.State = cn.State 
Where StateCode in ('AR', 'CT','BR', 'DL', 'KA','MH', 'UP') 
Group By StateCode
Order By StateCode;

## 9. Find out top 20 Districts with best recovery rate for Delta Cases ?
Select District, max(DeltaRecovered) as Good_R
FROM dataquest.detailedn
Group by District
ORDER BY Good_R limit 20;

## 10. For the state of Maharashtra, Gujarat and Goa List down top 2 districts with highest overall recovery rate (Normal + Delta) ?
Select distinct * From (SELECT State, District, MAX(Recovered) + MAX(DeltaRecovered) as Overall_Recovery_Rate 
FROM dataquest.detailedn
where State in ('Maharashtra','Goa','Gujarat')
group by District
order by Overall_Recovery_Rate DESC) as Stat
Order By Overall_Recovery_Rate DESC;
