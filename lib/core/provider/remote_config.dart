import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigService(this._remoteConfig);

  Future<void> initialize() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: Duration(seconds: 10),
          minimumFetchInterval: Duration(minutes: 1),
        ),
      );
      await _remoteConfig.fetchAndActivate();
      print("Remote Config fetched and activated.");
    } catch (e) {
      print("Failed to fetch remote config: $e");
    }
  }

  String get countryCode {
    final code = _remoteConfig.getString('country_code');
    print("Fetched country code: $code");
    return code;
  }
}
