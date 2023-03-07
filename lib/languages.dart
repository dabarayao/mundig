import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'fr_FR': {
          'About': 'A propos',
        },
        'es_US': {
          'About': 'Información',
        },
        'en_US': {
          'About': 'About',
        },
      };
}
