import 'package:common/logic/base.dart';
import 'package:common/model/state/loader_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loaderLogic = StateNotifierProvider<LoaderLogic, LoaderState>((ref) => LoaderLogic(ref.read));

class LoaderLogic extends BaseLogic<LoaderState> {
  LoaderLogic(Reader read) : super(read, const LoaderState());

  @override
  Future<void> initialize() async {}

  void showLoader() async {
    state = state.copyWith(hide: true, message: "");
  }

  void hideLoader() {
    state = state.copyWith(hide: false, message: "");
  }

  void showError(String error) {
    state = state.copyWith(hide: true, message: error);
  }

  void cancelError() {
    state = state.copyWith(hide: false);
  }

  void cancaledError() {
    state = state.copyWith(message: "");
  }
}
