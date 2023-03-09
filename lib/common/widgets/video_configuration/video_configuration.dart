import 'package:flutter/foundation.dart';

class VideoConfiguration extends ChangeNotifier {
  bool isMuted = false;
  bool isAutoPlay = false;
  void toggleIsMuted() {
    isMuted = !isMuted;
    notifyListeners();
  }

  void toggleAutoPlay() {
    isAutoPlay = !isAutoPlay;
    notifyListeners();
  }
}
