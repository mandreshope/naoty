import 'en_US/en_us_translations.dart';
import 'fr_FR/fr_fr_translations.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translations = 
  {
      'fr_FR' : frFR,
      'en_US' : enUs,
  };
}