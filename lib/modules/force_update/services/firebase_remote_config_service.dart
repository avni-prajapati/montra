import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigService {
  final remoteConfig = FirebaseRemoteConfig.instance;
  Future<void> initialize() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 0),
        minimumFetchInterval: const Duration(seconds: 0),
      ),
    );
    await remoteConfig.setDefaults(const {
      'requiredMinimumVersion': '2.0.0',
    });
    await remoteConfig.fetchAndActivate();
    remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.activate();
    });
  }

  String getRequiredMinimumVersion() =>
      remoteConfig.getString('requiredMinimumVersion');
}
