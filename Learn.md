Hi 😄, the implementation of the lung prognosis will be discussed here. A basic machine learning knowledge is preferred, so that the implementation can be understood straightforward.

### Implementation of the Lung Cancer Prognosis Model
Lung Cancer Prognosis was implemented with the help of Machine Learning libraries such as sklearn. This is a multi classification problem hence classification algorithms were used.
The dataset used for this classification had around 1000 rows/records and 25 columns where only 23 columns were able to be taken as features for prediction.
[Notebook](./models/Lung%20Cancer/Prognosis/Lung_Cancer_Prognosis.ipynb) | [Dataset](./models/Lung%20Cancer/Prognosis/LungDataSet.csv)

Before a model can be trained, we must first perform certain validations and checks (for data imbalance, presence of null values).
![](https://user-images.githubusercontent.com/54928498/169689164-76bcf81d-111c-47a0-bed4-688516288243.png)
![](https://user-images.githubusercontent.com/54928498/169689270-4412adfc-f139-4867-8eda-47ea4c4841c0.png)

There is no presence of null values, however the classes are quite imbalanced.

Since the dataset is quite imbalanced sampling must be done
![](https://user-images.githubusercontent.com/54928498/169689523-b54d8ea2-76a7-4084-bc5b-f140989694cd.png)

The following graphs are a comparison of the classes before and after sampling.
![](https://user-images.githubusercontent.com/54928498/169685173-4d094e0b-18b4-4bbb-9c74-004386b2648c.png)

Once all the Data preprocessing and cleaning is completed the dataset is split into a ratio of 25% and 75% as the Test and Train set
![](https://user-images.githubusercontent.com/54928498/169689334-81d65d23-a539-40d1-b652-7f6ed80e78ca.png)

Now that the data is prepped, we can start our model training. Since we do not know which exact algorithm would be the best for this use case multiple algorithms are tested against to be certain that the saved model is the best performing. (All model evaluations are present in the linked notebook)

Upon differentiating between the obtained evaluations it was determinded that the SVM performed the best.
![](https://user-images.githubusercontent.com/54928498/169689380-51450eb9-3519-430e-a34f-5c2b2b27a543.png)
![](https://user-images.githubusercontent.com/54928498/169689397-b8884c8a-fe2c-4f9b-94ce-2e01954d7f3b.png)

The confusion matrix is used as an evaluation metric, since solely accuracy is not reliable. 

To finish off the model implementation, the trained model is saved, so that it can be used in backend implementations, without the need to perform the training process again.
![](https://user-images.githubusercontent.com/54928498/169689422-2d03586a-b071-454d-9d7c-af079c8e2388.png)

### Using the saved model as a backend
Now that the model is available, we can whip out a basic flask server to serve as our backend.
[app.py](./api/prognosis/app.py)

Start off by initializing flask and loading the model
![](https://user-images.githubusercontent.com/54928498/169690779-3d7236f9-4a88-495d-8cce-62fc53fe4d05.png)
![](https://user-images.githubusercontent.com/54928498/169690744-b96dd9c3-64c5-445e-8c1d-4d396dcbb16f.png)

We can make a flask resource that will handle the prognosis of lung. Our request body will be a JSON object containing all of the properties that we pass as an argument to our request parser (these arguments are the same names as the columns of our dataset). Once the data is obtained, it is converted into a numpy array so that it can be fed into our model as an input to be evaluated.
![](https://user-images.githubusercontent.com/54928498/169690805-aac87ffc-d3bf-46bc-95e8-3ceed51d5d50.png)

Once this is done we can add our resource as an endpoint, so it can be accessed once deployed (or running locally).
![](https://user-images.githubusercontent.com/54928498/169691340-e34ea495-a158-4981-9fca-d2f84dbc03e3.png)

Now that our server is implemented, all that remains is to deploy it to a service that could host a flask app, in this case Heroku was used 😁.

### Special Considerations
* Since the free tier of Heroku is used, the app size limit is 512mb. For the case of machine learning models (pkl), the models are small in size, and hence Heroku is practical to be used. However, for the case of larger - deep learning models, an alternative must be considered. For the case of the deep learning models implemented in this project, Microsoft Azure was used through Azure Functions.
