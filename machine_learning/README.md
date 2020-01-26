# Melanoma Detection using Machine Learning

This app uses machine learning to detect melanoma in skin lesion images.  
The current model implements a pretrained convolutional neural network for general image classification that is transferred to the skin lesion classification problem.

#  Setup

The setup is only needed to modify and run the model. The app itself doesn't run the model but uses the resulting ```predict_melanoma.tflite``` model file to make predictions.
When commiting changes to the model, also commit the updated in ```frontend_molileo/assets/redict_melanoma.tflite``` so it will take effect in the app.

## Prerequisites

* [Conda 4.7+](https://github.com/conda/conda)

* [Python 3.6+](https://www.python.org/downloads/) 

* Create new conda environment: ```conda create -n molileo_env python=3.69```  
  Activate environment: ```conda activate molileo_env```  

### Install required packages:
* Jupyter Notebook:  ```conda install -c conda-forge notebook```  

* Numpy: ``` conda install -c anaconda numpy ```

* Tensorflow (GPU) 2.0: ``` conda install -c anaconda tensorflow-gpu```  
_Since tensorflow version 2, keras is already included. For tensorflow 1, also install keras module._

* Scikit-learn: ``` conda install -c anaconda scikit-learn```  

* Matplotlib: ``` conda install -c conda-forge matplotlib ```

* Pillow: ```conda install -c anaconda pillow```

### Dataset:
The dataset used to train the model consist of 224x224 dermatoscopic images of skin lesions, split into training, validation and test and separated by the labels: melanoma and non-melanoma. The origin of the data is the [Skin Cancer MNIST: HAM10000 challenge](https://www.kaggle.com/kmader/skin-cancer-mnist-ham10000), provided by the [ISIC Archive](https://www.isic-archive.com/#!/topWithHeader/wideContentTop/main). This dataset includes a variety of diagnostic categories. For the first version of the Molileo app we focus on detecting melanoma only. The source for the filtered dataset can be found on [Kaggle](https://www.kaggle.com/drscarlat/melanoma).
In order to run the notebook, download the [dataset](https://www.kaggle.com/drscarlat/melanoma) to ```machine_learning/datasets```. 

This dataset includes the following number of images:  
* training data: 5341 (melanoma) + 5341 (non-melanoma)
* validation data: 1781 (melanoma) + 1781 (non-melanoma)
* testing data: 1781 (melanoma) + 1780 (non-melanoma)  

The dataset provides a large sample size with equally distributed labels. This should be considered when using a different dataset for the same model.  

# Run the model

Run Jupyter Notebook in the ```molileo_env``` conda environment with: ```jupyter notebook```.  
Open ```machine_learning/'Mole Classification Prototype.ipynb'``` in jupyter and run.  

The training and testing duration will depend on the GPU.   
During development it was tested using one NVIDIA GeForce GTX 1050 GPU with 3 GB GDDR5 with the following durations:  
* 1 training epoch: **210s**
* 5 training epochs (current setting): **1053s** 
* predicting test data (3562 images): **35s**

# Model

## Architecture
The model utilizes [Google's MobileNet](https://ai.googleblog.com/2017/06/mobilenets-open-source-models-for.html), a pretrained computer vision model for tensorflow, using a convolutional neural network structure with 92 layers. This model is trained on millions of images belonging to 1000 different classes and is optimized for efficiency. Because of that it can be used for mobile applications despite its size and complexity.   
To see the full model architecture, use ```mobile.summary``` after loading the MobileNet.  
To transfer this general image classification model to our use-case, we replace the last layers with self defined layers. One dropout layer with a rate of 0.5 and a dense layer with two outputs for the two classes melanoma and non-melanoma.  
For the training process only the last two custom layers are trainable. The model is trained with the Adam optimizer and categorical crossentropy loss function.
Possible improvements for the network could be achieved using:  
* More custom layers.
* Fine-tuning the MobileNet model by allowing a part of the MobileNet model to be trainable.  
  * In first tests this achieved very slight improvements but doubling the training duration).
* Using newer versions of the MobileNet.
  * MobileNetV2 was tested but resulted in worse results for the current setup. So for a newer version the structure has to be adjusted.
* Fine-tuninge the hyperparameters.  
  * For the current prototype almost no different hyperparameters were tested, yet.

The most important point for future improvement however is not in the architecture but the data used for training. It is not tested, how well the model, trained on only dermatascopic images will translate to the photographs taken by the user. This can only be tested and improved with manually collecting actual dermatologist diagnosis for provided user/test photos.  
So, the main goal to achieve the best possible model is to accumulate the needed data. The performance of the model is completely dependant on the sample size of the collected data. We recommend a similar data size as the data used in the prototype.

## Results 

The performance of the model in relation to the false positive and true positive rate for different thresholds is shown in the ROC curve. The prototype achieves an area under the curve (AUC) of more than 0.95 for almost all tested configurations.   
The test with MobileNetV2 only achieved an AUC of 0.85, so we assume, that the current architecture is not suitable for the new version and has to be redesigned.

## Generated files

The model is exported to ```machine_learning/predict_melanoma.h5``` to test and reload the model when the memory has been reset.  
It is also exported to ```frontend_molileo/assets/predict_melanoma.tflite``` to be loaded from there in the frontend application and used for classification of the user's photos. Tensorflow Lite provides the possibility to run tensorflow models on frontend mobile devices. To make use of this, the tensorflow model is easily converted to a tflite model.

## Labels

```frontend_molileo/assets/labels.txt``` defines the labels for the classes. With two possible classes the model result of 0 is defined in the first line and the result of 1 is defined in the second line. This is used in the frontend application to load the name and description of the result.

## Interpreter

The notebook ```machine_learning/'Lite Interpreter.ipynb'``` provides an example for a python interpreter for tensorflow and tensorflow lite models. This is used to illustrate how to load a model from file, transform an example (melanoma) image to the correct input format and receive the classification for that image. It can also be used to test the model for single images.

# Literature

[Stanford/Nature](https://cs.stanford.edu/people/esteva/nature/)  
[Skin Cancer Classification using CNN](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6231861/)  
[Documentation Tensorflow Transfer Learning](https://www.tensorflow.org/tutorials/images/transfer_learning)  
[Documentation Tensorflow Lite](https://www.tensorflow.org/lite/)
