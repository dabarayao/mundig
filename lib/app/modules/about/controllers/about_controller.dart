import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

final box = GetStorage();

class AboutController extends GetxController {
  //TODO: Implement AboutController

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
