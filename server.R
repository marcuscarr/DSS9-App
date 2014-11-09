library(ggplot2)
data(trees)

dig <- function(num, digits = 1) {
    # Use to keep trailing zeros in a print statement.
    return(format(num, nsmall=digits))
}

shinyServer(function(input, output) {
    # Make new data frame with only selected variables
    selectedData <- reactive({
        data.frame(xval = trees[[input$xcol]], yval = trees[[input$ycol]])
    })
    
    # Fit a linear model
    makeFit <- reactive({
        lm(yval ~ xval, data = selectedData())
    })
    
    # Return prediction and CI for input NUM
    makePredict <- reactive({
        predict(makeFit(), data.frame(xval = input$num), 
                interval = "prediction", level = 0.68)
    })
    
    # Scatter plot of selected values
    output$treePlot <- renderPlot({
        # Make the plot and label axes
        p <- qplot(x = xval, y = yval, data = selectedData())
        p <- p + labs(x = input$xcol, y = input$ycol)
        
        # Add a line corresponding to the linear fit
        p <- p + stat_smooth(method = "lm")
        
        # If a predictor variable has been entered, plot a line for it as well.
        if (!is.numeric(input$num)) p 
        else {
            pred <- makePredict()
            p + annotate("pointrange",
                         x = input$num,
                         y = pred[1],
                         ymin = pred[2], 
                         ymax = pred[3],
                         size = 1.5,
                         color = "darkblue")
        }
    })
    
    output$num_text <- reactive({
        paste("Enter a value for", input$xcol)
    })
    
    output$fit_text <- reactive({
        # Print the numeric output from the linear model
        if (is.numeric(input$num)) {
            round_predict <- round(makePredict(),1)
            paste("Predicted", input$ycol, "is", dig(round_predict[1]), 
                  "with 68% CI", dig(round_predict[2]), 
                  "to", dig(round_predict[3]))
        } else ""
    })
    
    output$error_text <- reactive({
        # Warn if the input value is out of range for the supplied data
        select_data <- selectedData()
        if (is.numeric(input$num) && (
            input$num < min(select_data["xval"]) || 
                input$num > max(select_data["xval"]))) {
            "WARNING: Predictor value is out of range for the 
            training data set"
        } else ""
    })
    
})
