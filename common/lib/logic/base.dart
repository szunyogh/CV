import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseLogic<T> extends StateNotifier<T> {
  final Reader read;

  BaseLogic(this.read, T state) : super(state);

  Future<void> initialize();
}
