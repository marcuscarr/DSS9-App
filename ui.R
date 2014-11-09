shinyUI(pageWithSidebar(
    
    # Application title
    titlePanel("Girth, Height and Volume for Black Cherry Trees"),
    
    helpText("This app explores the built-in", code("trees"), "dataset in R.", 
             br(), br(),
             "Entering a value for the X-axis variable in 'Predictor'",
             "will give the predicted Y-axis value, rounded to 0.1.", 
             br(),
             "The predicted value and one-sigma CI (68%) are shown", 
             "on the scatter plot."),
    
    # Pulldown menus for variables to plot
    sidebarLayout(
        sidebarPanel(
            selectInput("xcol", label = "Select X-axis variable",
                        names(trees), selected = names(trees)[[1]]),
            
            selectInput("ycol", label = "Select Y-axis variable",
                        names(trees), selected = names(trees)[[3]]),
            
            numericInput("num", label = "Predictor", value = "", step = 0.5)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("treePlot"),
            div(textOutput("error_text")),
            div(textOutput("fit_text"))
        )
    )
))
