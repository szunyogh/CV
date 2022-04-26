import 'package:common/logic/base.dart';
import 'package:common/model/state/loader_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loaderLogic = StateNotifierProvider<LoaderLogic, LoaderState>((ref) => LoaderLogic(ref.read));

class LoaderLogic extends BaseLogic<LoaderState> {
  LoaderLogic(Reader read) : super(read, const LoaderState());

  @override
  Future<void> initialize() async {}

  void showLoader(String message) async {
    state = state.copyWith(hide: true, message: message);
  }

  void hideLoader() {
    state = state.copyWith(hide: false, message: "");
  }
}
