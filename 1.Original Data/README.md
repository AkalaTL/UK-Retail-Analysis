# data-science-test

Dear Candidate,

we are pleased to present your recruiting challenge. Here we go!

Instructions
------------

1. Clone this repository
2. Create a new `dev` branch
3. Place your code into *Rsolution.R*  and  *Psolution.py* . Comments and visuals can be named freely 
4. Do a pull request from the `dev` branch to the `master` branch 
5. Over email, reply to invitation for the test, telling us that we can start reviewing your code

We expect this test to take a couple of hours, but feel free to take as little or as much time as you like. One of our data scientists will then perform a code review and in next stage we might ask questions about your approach and results.

Data
----------

Dataset named 'UKretail.csv' contains a sample of transaction level data of a UK-based and registered non-store online retail business.The company mainly sells unique all-occasion gifts. Many customers of the company are wholesalers. Data span the period between 2010-12-01 and 2011-12-09 and stem from the UCI Machine Learning Repository (publicly available).

Your task
----------

Build a predictive model explaining either:
- time until next order per customer, or 
- revenue of next order per customer 

Selection is yours!

Hints
-----

1. All exploratory techniques and predictve models are allowed, as long as: 
  - you present only one solution / model, written in form of code
  - you use both R and Python; either language needs to be used for at least 25% of total solution. You are free to use any CRAN packages. As for Python, it's best to stick to packages included in latest release of Anaconda
  - if you produce visuals / graphs, entire related code needs to be included
  - your predictors are extracted only from given dataset. No external data are allowed
2. Please keep your solution concise and limited to relevant outputs only
3. You can attach comments to your solution either in the code or in a separate file
4. Exploratory data analysis and validation are part of the model
5. Please make all data paths relative so that we can easily rerun your code if needed


Attribute Information
----------------------

- InvoiceNo: Invoice number. Nominal, a 6-digit integral number uniquely assigned to each transaction. If this code starts with letter 'c', it indicates a cancellation
- StockCode: Product (item) code. Nominal, a 5-digit integral number uniquely assigned to each distinct product 
- Description: Product (item) name. Nominal
- Quantity: The quantities of each product (item) per transaction. Numeric	
- InvoiceDate: Invoice Date and time. Numeric, the day and time when each transaction was generated 
- UnitPrice: Unit price. Numeric, Product price per unit in GBP 
- CustomerID: Customer number. Nominal, a 5-digit integral number uniquely assigned to each customer.
- Country: Country name. Nominal, the name of the country where each customer resides

Good luck!

Your HelloFresh Recruiting Team
