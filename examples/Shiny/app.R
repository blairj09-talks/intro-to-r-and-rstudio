library(shiny)
library(parsnip)
library(ranger)
library(tidyverse)
library(pins)

board_register_rsconnect(server = "https://colorado.rstudio.com/rsc",
                         key = Sys.getenv("connect_key"))
model <- pin_get("james/credit_risk_model", board = "rsconnect")


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Credit Risk Prediction v2"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("age",
                        "Age:",
                        min = model$age[1],
                        max = model$age[3],
                        value = model$age[2]),
            selectInput("sex",
                        "Sex:",
                        choices = model$sex),
            selectInput("job",
                        "Job:",
                        choices = model$jobs),
            selectInput("housing",
                        "Housing:",
                        choices = model$housing),
            selectInput("saving_accounts",
                        "Saving Accounts:",
                        choices = model$saving_accounts),
            selectInput("checking_account",
                        "Checking Account:",
                        choices = model$checking_account),
            textInput("amount",
                      "Credit Amount:",
                      value = "1000.00"),
            sliderInput("duration",
                        "Duration:",
                        min = model$duration[1],
                        max = model$duration[3],
                        value = model$duration[2]),
            selectInput("purpose",
                        "Purpose:",
                        choices = model$purpose),
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
        predict(model$model, input_data(), type = "prob") %>% 
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
