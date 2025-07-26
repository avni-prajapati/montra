import 'package:montra_clone/modules/force_update/model/version_constraint_model.dart';

VersionConstraintModel getVersionNumberInInteger(String version) {
  List versionPoints = version.split('.');
  versionPoints = versionPoints.map((i) => int.parse(i)).toList();
  // final a = versionPoints[0] * 1000 + versionPoints[1] * 100 + versionPoints[2] * 10;
  return VersionConstraintModel(
    major: versionPoints[0],
    minor: versionPoints[1],
    patch: versionPoints[2],
  );
}
