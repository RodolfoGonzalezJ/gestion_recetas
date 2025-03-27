import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DDeviceUtility {
  // Método para ocultar el teclado
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  // Método para ocultar el teclado de forma asíncrona
  static Future<void> hideKeyboardAsync(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  // Método para cambiar el color de la barra de estado
  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );
  }

  // Metodos para tener la orientacion del dispositivo w
  static bool isLandScapeOrientation(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return viewInsets.bottom == 0;
  }

  static bool isPortraitOrientation(BuildContext context) {
    final viewInsents = MediaQuery.of(context).viewInsets;
    return viewInsents.bottom != 0;
  }

  // Metodo para full screen
  static Future<void> setFullScreen(bool enable) async {
    SystemChrome.setEnabledSystemUIMode(
      enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge,
    );
  }

  // Metodo para obtener el ancho de la pantalla
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(Get.context!).size.width;
  }

  // Metodo para obtener el alto de la pantalla
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(Get.context!).size.height;
  }
}
