# Info 201 Final Project - Asteroids

## Project Description
* What is the dataset you'll be working with?  Please include background on who collected the data, where you accessed it, and any additional information we should know about how this data came to be.

    The dataset we will be working with is a REST API that retrieves information about asteroids. The API was collected and is maintained by - SpaceRocks Team: David Greenfield, Arezu Sarvestani, Jason English and Peter Baunach. We found information about this data from a [programmableweb](https://www.programmableweb.com/api/nasa-asteroids-neo-feed), a website that has different kinds of APIS to explore

* Who is your target audience?  Depending on the domain of your data, there may be a variety of audiences interested in using the dataset.  You should hone in on one of these audiences.

    Our target audience can be anybody interested in relative asteroids in our solar system. Specifically, this API provides information on asteroids near Earth, so a group that would find this useful and interesting are people that have an interest in the movement and behavior of asteroids near Earth.

* What does your audience want to learn from your data?  Please list out at least 3 specific questions that your project will answer for your audience.

    * Which asteroid will be the next to approach Earth?
    * How many asteroids in the past 10 years have approached Earth?
    * How close, and what is the speed of the nearest asteroid to Earth right now?


## Technical Description


* How will you be reading in your data (i.e., are you using an API, or is it a static .csv/.json file)?
What types of data-wrangling (reshaping, reformatting, etc.) will you need to do to your data?

  Our data is read through an API from Rest. It returns a json object about each asteroid's infomation (distance, velocity, and so on). 
The type of data wrangligng we will need to is to reformat the data we have and to reshape so that it is easier to read, analyze and display. Sorting by asteriods whether they are pottentially dengerous or not can be one step.
  
* What (major/new) libraries will be using in this project (no need to list common libraries that are used in many projects such as dplyr)

  Other than the common major libraries, we think we might use either qgraph or tripack to help visualise distances. Also, gmapdistance or scales can be used to show the distance and time travel in the earth scale.

* What major challenges do you anticipate?
Not required, but optional: what questions, if any, will you be answering with statistical analysis/machine learning?

  One major challenge we can anticipate is taking into consideration the variability of User Input.
  Another major challenge we can anticipate is being able to work around dates and times, being as accurate as we can.
  Another major challenge is being able to properly display distances of asteroid according to what the user inputed
  or an aggregate mapping of all near asteroids.
