from pulp import *
from pandas import DataFrame, read_csv
import pandas as pd


# Reading the data file
file = r'diet.xls'
df = pd.read_excel(file, index = True, nrows=64)

#print(df.tail())


# Defining the LP
model = LpProblem("The Diet problem",LpMinimize)



# Setting up the problem
foods = df['Foods'].values
prices = df['Price/ Serving'].values
food_price = dict(zip(foods,prices))
nut_cols = df.columns[3:]
food_nuts = {food: {nut: df.loc[df["Foods"] == food, nut].values[0] for nut in nut_cols} for food in foods}


# Defining the variables
x = LpVariable.dicts("unit_of_food",foods,0)


min_nuts = [1500,30,20,800,130,125,60,1000,400,700,10]
max_nuts = [2500,240,70,2000,450,250,100,10000,5000,1500,40]



# Generatings the constriants
i = 0
for nut in nut_cols:
    model += lpSum([food_nuts[food][nut] * x[food] for food in foods]) >= min_nuts[i]
    model += lpSum([food_nuts[food][nut] * x[food] for food in foods]) <= max_nuts[i]
    i += 1





# Define the objective function
model += lpSum([food_price[food] * x[food] for food in foods]), "Total Cost per food"



# Solve LP
model.writeLP("The_Diet.lp")
model.solve()
print("Status:", LpStatus[model.status])
for sol in model.variables():
    print(sol.name, "=", sol.varValue)
