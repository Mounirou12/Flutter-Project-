import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';

class TranslationApi {
  static Future<String?> tanslatetext(String textscanne) async {
    try {
      final languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
      final languageCode =
          await languageIdentifier.identifyLanguage(textscanne);
      languageIdentifier.close();
      final traducteur = OnDeviceTranslator(
          sourceLanguage: TranslateLanguage.values
              .firstWhere((element) => element.bcpCode == languageCode),
          targetLanguage: TranslateLanguage.french);
      final translatedstext = await traducteur.translateText(textscanne);
      traducteur.close();
      return translatedstext;
    } catch (e) {
      return null;
    }
  }
}
