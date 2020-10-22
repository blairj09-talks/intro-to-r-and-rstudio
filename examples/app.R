library(shiny)
library(DBI)
library(parsnip)
library(ranger)
library(tidyverse)

con <- dbConnect(RSQLite::SQLite(), "data/credit")
credit_data <- dbReadTable(con, "credit")
dbDisconnect(con)

model <- readr::read_rds("credit-model.rds")


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Credit Risk Prediction"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("age",
                        "Age:",
                        min = min(credit_data$age),
                        max = max(credit_data$age),
                        value = median(credit_data$age)),
            selectInput("sex",
                        "Sex:",
                        choices = unique(credit_data$sex)),
            selectInput("job",
                        "Job:",
                        choices = sort(unique(credit_data$job))),
            selectInput("housing",
                        "Housing:",
                        choices = sort(unique(credit_data$housing))),
            selectInput("saving_accounts",
                        "Saving Accounts:",
                        choices = sort(unique(credit_data$saving_accounts))),
            selectInput("checking_account",
                        "Checking Account:",
                        choices = sort(unique(credit_data$checking_account))),
            textInput("amount",
                      "Credit Amount:",
                      placeholder = "1000.00"),
            sliderInput("duration",
                        "Duration:",
                        min = min(credit_data$duration),
                        max = max(credit_data$duration),
                        value = median(credit_data$duration)),
            selectInput("purpose",
                        "Purpose:",
                        choices = sort(unique(credit_data$purpose))),
            actionButton("submit", "Submit")
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("credit_score")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    input_data <- eventReactive(input$submit, {
        data.frame(
            age = input$age,
            sex = as.factor(input$sex),
            job = as.factor(input$job),
            housing = as.factor(input$housing),
            saving_accounts = as.factor(input$saving_accounts),
            checking_account = as.factor(input$checking_account),
            credit_amount = as.numeric(input$amount),
            duration = as.numeric(input$duration),
            purpose = as.factor(input$purpose)
        )
    })

    output$credit_score <- renderPlot({
        predict(model, input_data(), type = "prob") %>% 
            pivot_longer(cols = everything()) %>% 
            mutate(name = str_extract(name, "bad|good")) %>% 
            ggplot(aes(y = value, fill = name)) +
            geom_col(aes(x = 0)) +
            geom_text(aes(x = 0, label = round(value, 2)), position = position_stack(vjust = 0.5)) +
            geom_hline(yintercept = 0.5) +
            xlim(-2, 2) +
            theme_void() +
            theme(axis.ticks.y = element_blank(),
                  legend.position = "bottom",
                  legend.title = element_blank(),
                  axis.title.x = element_blank(),
                  axis.text.x = element_blank()) +
            coord_flip()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
