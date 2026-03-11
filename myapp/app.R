library(shiny)
library(bslib)
library(ggplot2)
library(dplyr)
library(scales)

grad_skills <- read.csv("data/processed/processed_data.csv")

min_year = min(grad_skills$Graduation_Year)
max_year = max(grad_skills$Graduation_Year)

regions = sort(unique(grad_skills$Region))
countries = sort(unique(grad_skills$Country))
studies = sort(unique(grad_skills$Field_of_Study))
degrees = sort(unique(grad_skills$Degree_Level))


# Define UI ----
ui <- page_sidebar(
  title = "Graduate Skills Employability Dashboard",
  sidebar = sidebar(
    helpText(
      "Explore various graduate skills and their employability from 2015-2025."
    ),
    accordion(
      accordion_panel(
        "Region",
        checkboxGroupInput(
          "region",
          NULL,
          choices = regions,
          selected = regions
        )
      ),
      accordion_panel(
        "Country",
        checkboxGroupInput(
          "country",
          NULL,
          choices = countries,
          selected = countries
        )
      ),
      accordion_panel(
        "Field of Study",
        checkboxGroupInput(
          "study",
          NULL,
          choices = studies,
          selected = studies
        )
      ),
      accordion_panel(
        "Degree Level",
        checkboxGroupInput(
          "degree",
          NULL,
          choices = degrees,
          selected = degrees
        )
      ),
      open=FALSE
    ),

    sliderInput(
      "grad_year",
      "Graduation Year",
      min = min_year,
      max = max_year,
      value = c(max_year - 4, max_year),
      step = 1,
      sep = ""
    ),
  ),
  
  layout_columns(
    card(
      card_header("Most Popular Industries"),
      plotOutput("top_industries", height= "100%")
    ),
    card(
      card_header("Yearly Average Starting Salary (USD)"),
      plotOutput("average_salary", height = "100%")
    ),
  ),
  card(
    card_header("Global Universities Field, Salary, and Degree Level "),
    dataTableOutput("university_table")
  )
)

# Define server logic ----
server <- function(input, output) {
  filtered <- reactive({
    grad_skills |>
      filter(
        Region %in% input$region,
        Country %in% input$country,
        Field_of_Study %in% input$study,
        Degree_Level %in% input$degree,
        Graduation_Year >= input$grad_year[1],
        Graduation_Year <= input$grad_year[2]
      )
  })
  
  output$top_industries <- renderPlot({
    filtered() |>
      add_count(Top_Industry) |>
      ggplot(aes(y = reorder(Top_Industry, n))) +
        geom_bar() +
        theme(
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          axis.text = element_text(size = 12, face = "bold"),
        )
  })
  
  output$average_salary <- renderPlot({
    filtered() |>
      group_by(Graduation_Year, Top_Industry) |>
      summarise(Average_Salary = mean(Average_Starting_Salary_USD)) |>
    ggplot(aes(Graduation_Year, Average_Salary, colour = Top_Industry)
    ) +
      geom_line() +
      theme(
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text = element_text(size = 12, face = "bold"),
        legend.position = "bottom",
        legend.title = element_blank(),
        legend.text = element_text(face = "bold")
      ) +
      scale_y_continuous(labels = scales::dollar_format())
  })
  
  output$university_table <- renderDataTable({
    filtered() |>
      #select(3, 2, 1, 5, 6, 9, 10)
      select(
        University = University_Name,
        Field = Field_of_Study,
        Degree = Degree_Level,
        `Average Salary` = Average_Starting_Salary_USD,
        Country,
        Region,
      ) |>
      arrange(desc(`Average Salary`))
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)