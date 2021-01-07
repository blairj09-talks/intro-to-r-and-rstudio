# Intro to R and RStudio

A brief introduction to R and RStudio with a special emphasis on the following
tools:
* [R Markdown](https://rmarkdown.rstudio.com/)
* [Shiny](https://shiny.rstudio.com/)
* [pins](https://pins.rstudio.com/)
* [Plumber](https://www.rplumber.io/)
* The [tidyverse](https://www.tidyverse.org/)
* [Connecting to databases from R](https://db.rstudio.com/)

# Examples
The examples in this repository are built around a German credit data set from
[Kaggle](https://www.kaggle.com/uciml/german-credit). This data was downloaded
from Kaggle, then loaded into a local SQLite database in order to illustrated\
connecting to a database from R.

### R Markdown
An example R Markdown report can be found at
[`examples/data-exploration.Rmd`](examples/data-exploration.Rmd). This document
briefly explores the described credit data and highlights how to connect to a
database from R and common use cases for the tidyverse.

### Pins
A small random forest model is trained on the credit data in
[`examples/credit-model.Rmd`](examples/credit-model.Rmd). The trained model is
saved as a pin on RStudio Connect. This R Markdown document is published to
RStudio Connect and set to run on a set schedule so the model is periodically
retrained. The pinned model is used by both the Shiny application and the
Plumber API.

### Shiny
An example Shiny application can be found at
[`examples/Shiny/app.R`](examples/Shiny/app.R). This application demonstrates
the power of Shiny as an interactive web framework by allowing the user to
select inputs into a credit risk model.

### Plumber
An example Plumber API can be found at
[`examples/Plumber/plumber.R`](examples/Plumber/plumber.R). This API
demonstrates how Plumber can be used to build web APIs using R. These APIs can
be published to RStudio Connect, which then allows other tools and frameworks to
access the API.

# Additional Resources
### [Cheatsheets](https://rstudio.com/resources/cheatsheets/)
A collection of useful single page references for common R packages and RStudio
tools.

### [R for Data Science](https://r4ds.had.co.nz/)
A great book for an introduction to the tidyverse for common data science tasks.

### [Advanced R](https://adv-r.hadley.nz/)
A deep dive into what makes R work as a language. Helpful if you're coming from
another programming background.

### [R Markdown Book](https://bookdown.org/yihui/rmarkdown/)
The definitive guide for all things R Markdown.

### [Mastering Shiny](https://mastering-shiny.org/)
A great book for learning more about Shiny and interactive applications in R.

### [Reproducable Finance with R](https://www.amazon.com/Reproducible-Finance-Portfolio-Analysis-Chapman/dp/1138484032)
A unique introduction to data science for investment management, authored by
Jonathan Regenstein.