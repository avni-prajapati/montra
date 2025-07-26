class VersionModel {
  VersionModel({
    this.updatedVersion,
    this.minimumVersionRequired,
  });

  String? updatedVersion;
  String? minimumVersionRequired;

  VersionModel.fromJson(dynamic json) {
    updatedVersion = json['updatedVersion'];
    minimumVersionRequired = json['minimumVersionRequired'];
  }
}
