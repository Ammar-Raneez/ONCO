# **Lung Cancer Prediction using Machine Leanring**

### **Importing the Libraries**

import numpy as np                # creating arrays for linear algebra
import pandas as pd               # used to create dataframes for data processing using the csv file
import seaborn as sns             # used for visualization
import matplotlib.pyplot as plt   # used for plotting data

#Reading the CSV data file

dataset = pd.read_csv("LungDataSet.csv")


#Exploring the dat

dataset.head(10)

print("Number of columns: "+str(len(dataset.columns)))
dataset.columns

dataset.shape    # 1000 rows and 25 columns

dataset.describe

print("The max value for AirPollution is",dataset['AirPollution'].max(),"and the min value is",dataset['AirPollution'].min())
print("The max value for Alcoholuse is",dataset['Alcoholuse'].max(),"and the min value is",dataset['Alcoholuse'].min())
print("The max value for DustAllergy is",dataset['DustAllergy'].max(),"and the min value is",dataset['DustAllergy'].min())
print("The max value for OccuPationalHazards is",dataset['OccuPationalHazards'].max(),"and the min value is",dataset['OccuPationalHazards'].min())
print("The max value for GeneticRisk is",dataset['GeneticRisk'].max(),"and the min value is",dataset['GeneticRisk'].min())
print("The max value for chronicLungDisease is",dataset['chronicLungDisease'].max(),"and the min value is",dataset['chronicLungDisease'].min())
print("The max value for BalancedDiet is",dataset['BalancedDiet'].max(),"and the min value is",dataset['BalancedDiet'].min())
print("The max value for Obesity is",dataset['Obesity'].max(),"and the min value is",dataset['Obesity'].min())
print("The max value for Smoking is",dataset['Smoking'].max(),"and the min value is",dataset['Smoking'].min())
print("The max value for PassiveSmoker is",dataset['PassiveSmoker'].max(),"and the min value is",dataset['PassiveSmoker'].min())
print("The max value for ChestPain is",dataset['ChestPain'].max(),"and the min value is",dataset['ChestPain'].min())
print("The max value for CoughingofBlood is",dataset['CoughingofBlood'].max(),"and the min value is",dataset['CoughingofBlood'].min())
print("The max value for Fatigue is",dataset['Fatigue'].max(),"and the min value is",dataset['Fatigue'].min())
print("The max value for WeightLoss is",dataset['WeightLoss'].max(),"and the min value is",dataset['WeightLoss'].min())
print("The max value for ShortnessofBreath is",dataset['ShortnessofBreath'].max(),"and the min value is",dataset['ShortnessofBreath'].min())
print("The max value for Wheezing is",dataset['Wheezing'].max(),"and the min value is",dataset['Wheezing'].min())
print("The max value for SwallowingDifficulty is",dataset['SwallowingDifficulty'].max(),"and the min value is",dataset['SwallowingDifficulty'].min())
print("The max value for ClubbingofFingerNails is",dataset['ClubbingofFingerNails'].max(),"and the min value is",dataset['ClubbingofFingerNails'].min())
print("The max value for FrequentCold is",dataset['FrequentCold'].max(),"and the min value is",dataset['FrequentCold'].min())
print("The max value for DryCough is",dataset['DryCough'].max(),"and the min value is",dataset['DryCough'].min())
print("The max value for Snoring is",dataset['Snoring'].max(),"and the min value is",dataset['Snoring'].min())

# Number of people with High Prob of getting cancer

numberOfHigh = dataset.loc[dataset.Level=="High"].count()
numberOfHigh

# Number of people with Medium Prob of getting cancer

numberOfMedium = dataset.loc[dataset.Level=="Medium"].count()
numberOfMedium

# Number of people with Low Prob of getting cancer

numberOfLow = dataset.loc[dataset.Level=="Low"].count()
numberOfLow


#Plotting a bar graph against the number

x = ["Low","Medium", "High"]
y = [303, 332, 365]

plt.title("Distribution")
plt.ylabel("Number of records")
plt.xlabel("Level of risk")
plt.bar(x,y)
plt.show()


# Checking for any null values in the data
dataset.isnull().values.any()

# Cleaning data process
dataset['Gender'] = dataset['Gender'].replace(2, 0)   # 0 means Female and 1 means Male

# Data Visulization
#sns.pairplot(dataset)



# Performing Train Test Split

from sklearn.metrics import confusion_matrix, accuracy_score, recall_score, precision_score
from sklearn.model_selection import train_test_split 

# dividing X, y into train and test data 
X_train, X_test, y_train, y_test = train_test_split(X, y, random_state = 101)























