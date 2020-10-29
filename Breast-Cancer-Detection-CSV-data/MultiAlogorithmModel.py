#This program detects breast cancer, based on data.
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns


#load data
breast_data = pd.read_csv("breast-cancer.csv")
breast_data.head()

#count number of rows and columns in dataset
# breast_data.shape


#count number of empty values of each column
breast_data.isna().sum()


#drop id an completely empty unnamed column
breast_data = breast_data.drop('Unnamed: 32', axis=1)
breast_data = breast_data.drop('id', axis=1):


breast_data.head()


# breast_data.shape


#Number of malignant and benign cells
breast_data['diagnosis'].value_counts()


#visualize the data count
sns.countplot(breast_data['diagnosis'], label='count')


#check data types to identify which values to encode to numbers
# breast_data.dtypes


#As identified above the diagnosis column needs to be encoded
from sklearn.preprocessing import LabelEncoder

diagnosis_encoder = LabelEncoder()
#convert the first column into 0s and 1s
breast_data.iloc[:,0] = diagnosis_encoder.fit_transform(breast_data.iloc[:,0].values)


# breast_data.dtypes


#create a pair plot
sns.pairplot(breast_data.iloc[:,0:6], hue='diagnosis')


breast_data.head()


#Get correlations of data with every column
breast_data.iloc[:,0:12].corr()


#Visualize correlation
plt.figure(figsize=(15, 15))
sns.heatmap(breast_data.iloc[:,0:12].corr(), annot=True, fmt='.0%')


#spitting data into input and output datasets
X = breast_data.iloc[:,1:].values
y = breast_data.iloc[:,0].values


#split data into 75%, 25% train and test
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25, random_state=0)


#scale data to bring all values to same range
from sklearn.preprocessing import StandardScaler
sc = StandardScaler()
X_train = sc.fit_transform(X_train)
X_test = sc.fit_transform(X_test)

X_train


def model(X_train, y_train):
    #Logistic Regression
    from sklearn.linear_model import LogisticRegression
    logistic_reg = LogisticRegression(random_state = 0)
    logistic_reg.fit(X_train, y_train)
    
    #Decision Tree
    from sklearn.tree import DecisionTreeClassifier
    decision_tree = DecisionTreeClassifier(criterion='entropy', random_state = 0)
    decision_tree.fit(X_train, y_train)
    
    #Support Vector Machines
    from sklearn import svm
    support_vm = svm.SVC(kernel='linear', C=1)
    support_vm.fit(X_train, y_train)
    
    #Random Forest
    from sklearn.ensemble import RandomForestClassifier
    random_for = RandomForestClassifier(n_estimators = 10, criterion='entropy', random_state = 0)
    random_for.fit(X_train, y_train)
    
    #Print model accuracy for the training data
    print("Logistic Regression Training Accuracy:", logistic_reg.score(X_train, y_train))
    print("Decision Tree Training Accuracy:", decision_tree.score(X_train, y_train))
    print("SVM Training Accuracy:", support_vm.score(X_train, y_train))
    print("Random Forest Training Accuracy:", random_for.score(X_train, y_train))
    
    return logistic_reg, decision_tree, support_vm, random_for


#getting all of the models
all_models = model(X_train, y_train)


#Test data on the confusion matrix
#Combines the Sensitivity, Specificity and the Positive/ Negative Predicted Value(PPV/ NPV)
from sklearn.metrics import confusion_matrix

models = ["Logistic Regression", "Decision Tree", "SVM", "Random Forest"]

for i in range(len(all_models)):
    print("Model:", models[i])
    model_cm = confusion_matrix(y_test, all_models[i].predict(X_test))
    
    model_TP = model_cm[0][0]
    model_TN = model_cm[1][1]
    model_FN = model_cm[1][0]
    model_FP = model_cm[0][1]
    
    print(model_cm)
    print("Testing Accuracy:", (model_TP + model_TN) / (model_TP + model_TN + model_FP + model_FN))
    print("Sensitivity:", (model_TP) / (model_TP + model_FN))
    print("Specificity:", (model_TN) / (model_TN + model_FP))
    print()


from sklearn.metrics import classification_report
from sklearn.metrics import accuracy_score

for i in range(len(all_models)):
    print("Model:", models[i])
    print(classification_report(y_test, all_models[i].predict(X_test)))
    print(accuracy_score(y_test, all_models[i].predict(X_test)))
    print()


# #Retrain random forest 30X to obtain most accurate model
# from sklearn.ensemble import RandomForestClassifier
# best_accuracy = 0
# best_model = [0]
# for _ in range(30):
#     random_for = RandomForestClassifier(n_estimators = 10, criterion='entropy', random_state = 0)
#     random_for.fit(X_train, y_train)
#     pred = random_for.score(X_train, y_train)
#     if pred > best_accuracy:
#         best_accuracy = pred
#         best_model[-1] = random_for
# print("Random Forest Best Training Accuracy:", best_accuracy)


# from sklearn.metrics import confusion_matrix
# test = 0
# sens = 0
# spec = 0

# for _ in range(30):
#     model_cm = confusion_matrix(y_test, best_model[-1].predict(X_test))
    
#     model_TP = model_cm[0][0]
#     model_TN = model_cm[1][1]
#     model_FN = model_cm[1][0]
#     model_FP = model_cm[0][1]
    
#     test_acc = (model_TP + model_TN) / (model_TP + model_TN + model_FP + model_FN)
#     if test_acc > test:
#         test = test_acc
    
#     sensitivity = (model_TP) / (model_TP + model_FN)
#     if sensitivity > sens:
#         sens = sensitivity
        
#     specificity = (model_TN) / (model_TN + model_FP)
#     if specificity > spec:
#         spec = specificity
    
# print("Testing Accuracy:", (model_TP + model_TN) / (model_TP + model_TN + model_FP + model_FN))
# print("Sensitivity:", (model_TP) / (model_TP + model_FN))
# print("Specificity:", (model_TN) / (model_TN + model_FP))


#print predictions of the best classifier - random forest
predictions = all_models[-1].predict(X_test)
print(predictions)
print()
print(y_test)

import pickle
with open("Best-Model-Random-Forest.pickle", "wb") as f:
    pickle.dump(all_models[-1], f)

