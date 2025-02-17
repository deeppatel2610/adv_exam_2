import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

var authController = Get.put(AuthController());

class AuthController extends GetxController {
  var tetEmail = TextEditingController();
  var tetPassword = TextEditingController();
}
