import 'package:flutter_bloc/flutter_bloc.dart';

class FlightStartupCubit extends Cubit<int> {
  FlightStartupCubit() : super(0);

  void changeIndex(int newIndex) {
    if (state != newIndex) {
      emit(newIndex);
    }
  }
}
