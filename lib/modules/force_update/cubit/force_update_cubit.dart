import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/modules/force_update/api_client.dart';
import 'package:montra_clone/modules/force_update/model/version_model.dart';

part 'force_update_state.dart';

class ForceUpdateCubit extends Cubit<ForceUpdateState> {
  ForceUpdateCubit() : super(const ForceUpdateState());

  Future<void> fetchMinimumVersionRequired() async {
    try {
      emit(state.copyWith(apiStatus: ApiStatus.loading));
      final json = await ApiClient.instance
          .callApi("https://api.npoint.io/938ba00338f0314538ab");
      final versionModel = VersionModel.fromJson(json);
      emit(state.copyWith(
        apiStatus: ApiStatus.success,
        requiredMinimumVersion: versionModel.minimumVersionRequired,
      ));
    } catch (e) {
      emit(state.copyWith(apiStatus: ApiStatus.failure));
    }
  }
}
