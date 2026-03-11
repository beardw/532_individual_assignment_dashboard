# Graduate Skills Employability Dashboard

## 532 Individual Assignment Dashboard

Welcome to an R version of the Graduate Skills Employability Dashboard. It has a similar feel and layout to its predecessor, however, it is simpler and I have decided to display the data differently than how it was presented in the large team-created dashboard. 

Users can continue to explore popular industries, fields of study, degree levels, and various salary ranges for universities located across the globe. The aim remains the same: help those make informed decisions regarding their future educational persuits.

To be able to run this dashboard locally, you will need to have the packages listed below.

If you do not have them, open an R session, connect to the internet, and run the following:

```r
install.packages("shiny")
install.packages("bslib")
install.packages("dplyr")
install.packages("scales")
```

Once installed, clone this repository and navigate to the root directory.

```bash
git clone git@github.com:beardw/532_individual_assignment_dashboard.git
cd 532_individual_assignment_dashboard
```

To run the Shiny app from RStudio's IDE, open the app.R file and press the "Run App" button. This will render and create a connection to an instance of the dashboard. You can decide to have this open in an external browser or your IDE. 

Another option is to run the following code in the RStudio console.

```r
runApp('~/your/path/to/myapp')
```

## Deployed Dashboard

Follow link: [https://019cdb84-999c-c754-30be-dd20e16dbee8.share.connect.posit.cloud/](https://019cdb84-999c-c754-30be-dd20e16dbee8.share.connect.posit.cloud/)
