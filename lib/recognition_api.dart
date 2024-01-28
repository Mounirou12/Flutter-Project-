import 'package:google_ml_kit/google_ml_kit.dart';

class RecognitionApi {
  static Future<String?> scannertext(InputImage file) async {
    try {
      final textscann = TextRecognizer();
      final textreconnu = await textscann.processImage(file);
      return textreconnu.text;
    } catch (e) {
      return null;
    }
  }
}
