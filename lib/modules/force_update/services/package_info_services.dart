import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoServices {
  static final PackageInfoServices instance = PackageInfoServices.internal();
  factory PackageInfoServices() => instance;
  PackageInfoServices.internal();

  late String version;

  Future<void> initialize() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
  }
}
