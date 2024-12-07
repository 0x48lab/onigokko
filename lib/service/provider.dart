
import 'package:onigokko/viewmodel/register_page_viewmodel.dart';
import 'package:riverpod/riverpod.dart';

final registerProvider =
StateNotifierProvider<RegisterPageViewmodel, RegisterState>(
      (ref) => RegisterPageViewmodel(),
);