part of 'force_update_cubit.dart';

enum ApiStatus { initial, loading, success, failure }

class ForceUpdateState extends Equatable {
  const ForceUpdateState({
    this.requiredMinimumVersion = '',
    this.apiStatus = ApiStatus.initial,
  });

  final String requiredMinimumVersion;
  final ApiStatus apiStatus;

  @override
  List<Object?> get props => [
        requiredMinimumVersion,
        apiStatus,
      ];

  ForceUpdateState copyWith({
    String? requiredMinimumVersion,
    ApiStatus? apiStatus,
  }) {
    return ForceUpdateState(
      requiredMinimumVersion:
          requiredMinimumVersion ?? this.requiredMinimumVersion,
      apiStatus: apiStatus ?? this.apiStatus,
    );
  }
}
