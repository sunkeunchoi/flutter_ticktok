import 'package:flutter/cupertino.dart';

class VideoConfiguration extends ChangeNotifier {
  bool autoMute = false;
  void toggleAutoMute() {
    autoMute = !autoMute;
    notifyListeners();
  }
}

final videoConfig = VideoConfiguration();
