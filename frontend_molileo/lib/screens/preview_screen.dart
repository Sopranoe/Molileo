/*
 * Copyright (c) 2019 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_molileo/screens/result_screen.dart';
import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as img;

class PreviewImageScreen extends StatefulWidget {
  final String imagePath;
  PreviewImageScreen({this.imagePath});

  @override
  _PreviewImageScreenState createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  List _recognitions;
  String res = "";
  String recognitions = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text('Molileo',
            style: TextStyle(color: Colors.black, fontSize: 25.0)),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Expanded(
                child: Image.file(File(widget.imagePath), fit: BoxFit.cover)),
            SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70.0,
                  height: 70.0,
                  child: FloatingActionButton(
                    heroTag: 'clear',
                    child: Icon(
                      Icons.clear,
                      color: Colors.red,
                      size: 40.0,
                    ),
                    backgroundColor: Colors.grey[400],
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  width: 50.0,
                ),
                SizedBox(
                  width: 70.0,
                  height: 70.0,
                  child: FloatingActionButton(
                    heroTag: 'check',
                    child: Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 40.0,
                    ),
                    backgroundColor: Colors.grey[400],
                    onPressed: () {
                      this.loadModel();
                      // _accept(context, widget.imagePath);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 100.0)
          ],
        ),
      ),
    );
  }

  void _accept(context, String path) async {
    // console.log('Ausgabe: ' + recognitions);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultImageScreen(imagePath: path)));
  }
  // }

  void loadModel() async {
    this.res = await Tflite.loadModel(
        model: "assets/predict_melanoma.tflite",
        labels: "assets/labels.txt",
        numThreads: 1 // defaults to 1
        );

    File imgFile = new File(widget.imagePath);
    await recognizeImageBinary(imgFile);

    print('_recognitions');
    print(_recognitions);

    await Tflite.close();
  }

  Future recognizeImageBinary(File image) async {
    var imageBytes = (await rootBundle.load(image.path)).buffer;
    img.Image oriImage = img.decodeJpg(imageBytes.asUint8List());
    img.Image resizedImage = img.copyResize(oriImage, 224, 224);
    var recognitions = await Tflite.runModelOnBinary(
        binary: imageToByteListFloat32(resizedImage, 224, 127.5, 127.5),
        numResults: 6,
        threshold: 0.05,
        asynch: true);
    setState(() {
      _recognitions = recognitions;
    });
  }

  Uint8List imageToByteListFloat32(
      img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }
}
