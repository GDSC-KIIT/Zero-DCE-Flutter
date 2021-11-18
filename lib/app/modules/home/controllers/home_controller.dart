import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeController extends GetxController {
  final panelController = PanelController();
  void showBottomPanel() => panelController.open();
  void showCamBody() {
    panelController.close();
  }
}
