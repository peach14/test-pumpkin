import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddQuantityState extends StateNotifier<List<bool>> {
  AddQuantityState(List<bool> state) : super(state);

  void updateItemAtIndex(int index, bool value) {
    state[index] = value;
    state = List.from(
        state); // This line is to notify listeners of the state change
  }
}
