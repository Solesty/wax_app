import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// this is a model/state
class SettingsProvider with ChangeNotifier {
  String _units;
  List<String> _waxLines;

  SettingsProvider() {
    _units = "Imperial";
    _waxLines = ['Swix', 'Toko'];
    loadPreferences();
  }

  // Getters
  String get units => _units;
  List<String> get waxLines => _waxLines;

  // Setters
  void setUnits(String units) {
    _units = units;
    // WHAT YOU CAN DO
    // loading state
    // notifyListeners();

    // might take long
    savePreferences();

    // done loading
    // notifyListeners();

    notifyListeners();
  }

  void _setWaxLines(List<String> waxLines) {
    _waxLines = waxLines;
    savePreferences();
    notifyListeners();
  }

  void addWaxLine(String waxLine) {
    if (_waxLines.contains(waxLine) == false) {
      _waxLines.add(waxLine);
      notifyListeners();
    }
  }

  void removeWaxLine(String waxLine) {
    if (_waxLines.contains(waxLine) == true) {
      _waxLines.remove(waxLine);
      notifyListeners();
    }
  }

  savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("units", this._units);
    prefs.setStringList("waxLines", this._waxLines);
  }

  loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String units = prefs.getString("units");
    List<String> waxLines = prefs.getStringList("waxLines");

    if (units != null) {
      setUnits(units);
    }

    if (waxLines != null) {
      _setWaxLines(waxLines);
    }
  }
}
