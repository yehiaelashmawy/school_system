import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/core/helper/shared_prefs_helper.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(SharedPrefsHelper.isDarkMode);

  void toggleTheme() async {
    final newValue = !state;
    await SharedPrefsHelper.setIsDarkMode(newValue);
    emit(newValue);
  }
}
