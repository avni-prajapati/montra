part of 'configuration_cubit.dart';

enum ApiStatus { initial, loading, success, failure }

class ConfigurationState extends Equatable {
  const ConfigurationState({
    this.status = ApiStatus.initial,
    this.currentIndex = 0,
  });

  final ApiStatus status;
  final int currentIndex;

  @override
  List<Object?> get props => [status, currentIndex];

  ConfigurationState copyWith({
    ApiStatus? status,
    int? currentIndex,
  }) {
    return ConfigurationState(
      status: status ?? this.status,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
