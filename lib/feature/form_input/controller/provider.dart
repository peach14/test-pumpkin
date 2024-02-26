import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../form_input/controller/check_stock_controller.dart';
import '../../login/controller/provider.dart';
import 'add_quantity_controller.dart';

final asyncChStockProvider =
    AsyncNotifierProvider<ChStockAsyncNotifier, dynamic>(
        (ChStockAsyncNotifier.new));

final addQuantityProvider =
    StateNotifierProvider<AddQuantityState, List<bool>>((ref) {
  final successLogin = ref.watch(asyncLoginProvider);
  final dataLength = successLogin.maybeWhen(
    orElse: () => 0,
    data: (data) => data['saveData'].length,
  );
  return AddQuantityState(List.generate(dataLength, (index) => true));
});

final updateIndex = StateProvider<int>((ref) => 0);
final defolIndex = StateProvider<int>((ref) => 0);
