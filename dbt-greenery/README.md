Project questions
Imagine you’re a new analytics engineer at a tech startup, greenery, that delivers flowers and houseplants. They’ve hired you as the first data person to help them understand the state of the business and determine where they need to improve to grow revenue and acquire new customers. You’ve heard of dbt, the tool every analytics engineer needs to learn how to use, and decide to start a dbt project to layout and transform the data you have available to you.

(1) Start a new dbt project
Note: we've re-posted the setting up on gitpod and dbt project videos below that are included in week 1

(2) Using source data in our data warehouse and dbt models, set up the staging models and, where applicable, snapshot models, for each source (raw) table.
Note: details on source tables, staging models, snapshots, etc is included in week 1 dbt fundamentals part 1 + 2.

Using the instructions in the two videos below:
Setup the dbt project called greenery which creates the project folder structure
Configure the dbt_project.yml and profiles.yml files with the right credentials
For all the tables (7) in the greenery schema shown in the ER diagram above:
Configure source.yml file with the seven sources
Create staging dbt model from each of them (You’ll end up with seven .sql files)
NOTE: staging tables should have all the columns the source table has
Create a snapshot model for sources for which it makes sense. (.sql files)
HINT: Does events need a snapshot or not really?
Update schema.yml files with all the staging model names and descriptions
Run your dbt models and snapshots against the data warehouse using the appropriate dbt commands
You'll now save project code to your github repo

(3) Answer these questions using the data available using SQL queries. You can query either the dbt generated tables or the source tables here. For these short answer questions/queries create a separate readme file in your repo with your answers.
How many users do we have?
On average, how many orders do we receive per hour?
On average, how long does an order take from being placed to being delivered?
How many users have only made one purchase? Two purchases? Three+ purchases?
On average, how many unique sessions do we have per hour?