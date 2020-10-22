# Intro to R and RStudio

A brief introduction to R and RStudio with a special emphasis on the following
tools:
* [R Markdown](https://rmarkdown.rstudio.com/)
* [Shiny](https://shiny.rstudio.com/)
* The [tidyverse](https://www.tidyverse.org/)
* [Connecting to databases from R](https://db.rstudio.com/)

# Examples
The examples in this repository are built around a German credit data set from
[Kaggle](https://www.kaggle.com/uciml/german-credit). This data was downloaded
from Kaggle, then loaded into a local SQLite database in order to illustrated
connecting to a database from R.

### R Markdown
An example R Markdown report can be found at
[examples/data-exploration.Rmd](examples/data-exploration.Rmd). This document
briefly explores the described credit data and highlights how to connect to a
database from R and common use cases for the tidyverse.

### Shiny
An example Shiny application can be found at [examples/app.R](examples/app.R).
This application demonstrates the power of Shiny as an interactive web framework
by allowing the user to select inputs into a credit risk model.

# Additional Resources
### [Cheatsheets](https://rstudio.com/resources/cheatsheets/)
A collection of useful single page references for common R packages and RStudio
tools.

### [R for Data Science](https://r4ds.had.co.nz/)
A great book for an introduction to the tidyverse for common data science tasks.

### [R Markdown Book](https://bookdown.org/yihui/rmarkdown/)
The definitive guide for all things R Markdown.

### [Mastering Shiny](https://mastering-shiny.org/)
A great book for learning more about Shiny and interactive applications in R.

### [Reproducable Finance with R](https://www.amazon.com/Reproducible-Finance-Portfolio-Analysis-Chapman/dp/1138484032)
A unique introduction to data science for investment management, authored by
Jonathan Regenstein.