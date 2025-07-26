import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'configuration_state.dart';

class ConfigurationCubit extends Cubit<ConfigurationState> {
  ConfigurationCubit() : super(const ConfigurationState());

  void setCurrentIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
