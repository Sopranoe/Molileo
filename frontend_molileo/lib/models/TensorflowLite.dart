import 'package:tflite/tflite.dart';

class TensorflowLite {
  final String scriptPath;
  final String labelPath;
  String res;

  TensorflowLite(this.scriptPath, this.labelPath);

  void init() async {
    res = await Tflite.loadModel(
        model: "assets/predict_melanoma.tflite",
        labels: "assets/labels.txt",
        numThreads: 1 // defaults to 1
        );

    print('Model loaded');
  }

  Future<List> runModelOnImage(context, String path) async {
    print('Ausgabe: ');
    return await Tflite.runModelOnImage(
        path: path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.5, // defaults to 0.1
        asynch: true // defaults to true
        );
  }

  void close() async {
    await Tflite.close();
  }
}
