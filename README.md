Code for a [webapp](https://codith.shinyapps.io/trees-app/) for [Developing Data Products](https://www.coursera.org/course/devdataprod).

Girth, Height and Volume for Black Cherry Trees
===============================================

This app allows the user to explore the `trees` data set that comes built into R.

## The data set

From the R documentation:

>This data set provides measurements of the girth, height and volume of timber in 31 felled black cherry trees. Note that girth is the diameter of the tree (in inches) measured at 4 ft 6 in above the ground.

## The app

The user can select which pairwise set of variables they wish to display. The scatter plot is updated and a linear model (with model confidence intervals) is plotted as well.

The app can also be used to make predictions. Entering a value in the indicated box will do two things:

1. A prediction for the Y-axis variable will be given, along with the 68% confidince interval.

2. The predicted point and its confidence interval will be added to the plot.

## FAQ

- "Help! I entered a value but there is no prediction shown. What now?"

  If you press return or click outside of the number entry box, you will get your prediction.

- "Can I use this to make predictions for 1,000-foot trees?"

  You can, but you shouldn't. You will receive a warning along with your prediction in this case.
