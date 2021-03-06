import 'package:flutter/material.dart';

class BaseNotifier extends ChangeNotifier {
  bool _busy = false;
  bool _mounted = true;

  bool get busy => _busy;
  bool get mounted => _mounted;

  void setBusy(bool value) {
    _busy = value;
    if (mounted) notifyListeners();
  }

  void setState() {
    if (mounted) notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
