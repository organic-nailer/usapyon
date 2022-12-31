import 'package:shared_preferences/shared_preferences.dart';

class GameStorage {
  static GameStorage get instance {
    if (_instance != null) return _instance!;
    _instance = GameStorage();
    return _instance!;
  }
  static GameStorage? _instance;
  GameStorage();

  void saveMotionEnabled(bool value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool("MOTION", value);
    print("saved pref: MOTION -> $value");
  }

  Future<bool?> getMotionEnabled() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool("MOTION");
  }

  void saveScore(double height) async {
    final preferences = await SharedPreferences.getInstance();
    final currentHighScore = preferences.getDouble("HIGH_SCORE") ?? 0;
    if (currentHighScore < height) {
      await preferences.setDouble("HIGH_SCORE", height);
      print("saved pref: HIGH_SCORE -> $height");
    }
  }

  Future<double?> getHightScore() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getDouble("HIGH_SCORE");
  }
}
