import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_pumpkin/feature/login/controller/login_controller.dart';

final asyncLoginProvider = AsyncNotifierProvider<LoginAsyncNotifier, dynamic>(
    (LoginAsyncNotifier.new));
