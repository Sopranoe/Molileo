import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class InformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String appDescription =
        "Skin cancer nowadays is one of the most common cancer forms and can appear in all ages, genders and anywhere on the skin. The first signs of skin cancer are often abnormal skin signs that can go from patches or moles to lesions on the. These irregularities often show a rather unnatural growth. the appearance of skin cancer has been on the rise for years and the cases are increasing every year, but when found in an early stage, most skin cancer types can be treated rapidly. This shows the importance of letting your skin be checked in a regular  period of time to make sure you recognize irregularities in early stages and let them be checked by a doctor. Our Application can help you to document, track and assess any abnormal patches, moles or lesions, but it can not replace a doctors visit (also see the Important Information & Disclaimer section down below). Melanoma is the most dangerous form of skin cancer, but skin cancer can come in many other forms and it is important to pay attention to any irregularities and be aware of different forms skin-cancer can take and to know what to look for. Our Application does want to help you being provided with the best information possible.";
    String causes = "Skin cancer is caused by the mutuation of skin cells in the DNA. In 90% of the cases, this mutuation is caused by an intense and coninous UV exposure of the skin from the sun. Nevertheless, first signs of skin cancer appear in places that are hiffen from direct sunlight. Studies reveal  that exposure to toxics can as much be a reason, for example from the environment that you live in, as genetics can be a cause of skin cancer. In the graphic down below we show you the risks of skin cancer in the specific body parts.";
    String disclaimer = "The services of this application are there to help you creating an awareness of your skin health, to monitor and track irregularities and to create an initial assessment. Our services are therefore providing help in understanding what to look for, but cannot be used solely for diagnostic or treatment purposes. This service does not replace a visit to the doctor. Any reliance on our service and our recommendations is always at your own risk. This service should always only be used as an extension to a doctor visit. It is strongly recommended that you discuss your personal risk factors and the results of your review with your doctor. Our application cannot be made liable if you do not discuss your skin health with your doctor. Our  App does not guarantee the correct assessment based on our  data sets or programmatic libraries integrated in the app. we make it clear that we did not procure the data sets ourselves, but instead refer to scientific data sets that are openly accessible on the internet when evaluating the skin.";
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: const Text('Molileo',
              style: TextStyle(color: Colors.black, fontSize: 25.0)),
          centerTitle: true,
          backgroundColor: Colors.grey[100],
        ),
        body:  new SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: new Text('What our App is helping you with',
                      style: new TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    appDescription,
                    style: new TextStyle(fontSize: 20.0),
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: new Text('The causes of skin cancer',
                      style: new TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    causes,
                    style: new TextStyle(fontSize: 20.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: new Text('Important information and disclaimer',
                      style: new TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    disclaimer,
                    style: new TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
