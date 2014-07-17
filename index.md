---
title       : Shiny app presentation
subtitle    : Comparing unemployment rates
author      : José Luis Cañadas Reche
job         : IESA-CSIC
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Why

Unemployment  rate is the principal economic problem in Spain. Spanish regions have different kind of unemployment rate. Age and education are important variables in order to get a job.  It has sense  research their  unemployment rate evolution across the regions

[EPA microdata](http://www.ine.es/en/inebaseDYN/epa30308/epa_microdatos_en.htm) is the official survey to research labour market. It's a panel where the people have interviewed each 3 months. In each wave, around 170,000 persons answer the survey.

Previously we have calculated unemployment rate by region, age groups and education level for each period since 2008. You can see how to do for one particular wave in this [rpubs document](http://rpubs.com/joscani/unemplrate)

With this app we can explore how to change unemployment rate across the time and compare regions, including important labour variables like age and education.

---
## Data
Once we have got the unemployment rate for each region, age group and education level since 2008, we put together in a data.frame. 
**Load data and see some rows** 

```r
load("../data/data.rda")
dim(data)
```

```
## [1] 4500    7
```

```r
data[1:3,]
```

```
##   ciclo      ccaa ccaa.n           gedad                nforma3   paro
## 1   142 Andalucía      1 16-34 years old Primary school or less 0.2873
## 2   142 Andalucía      1 16-34 years old              Secondary 0.1903
## 3   142 Andalucía      1 16-34 years old             University 0.1275
##   ciclonombre
## 1     1T 2008
## 2     1T 2008
## 3     1T 2008
```



---

## Unemployment rate
Some definitions:

* Population of 16 years old or older is subdivided in active + inactive population
* Active population :  employed + unemployed 
* Inactive population: Students, retired, unable to work and other situations

* __Unemployment rate__ : It is the ratio between the number of unemployed and active population.



---

## The App
Explain the visualization  and include a little figure to show.

2. Visualization

---

## Code example in server.R






