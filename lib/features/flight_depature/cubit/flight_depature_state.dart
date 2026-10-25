import 'package:operation_app/features/flight_depature/model/flight_depature_model.dart';

abstract class FlightDepatureState {}

class FlightDepatureInitial extends FlightDepatureState {}

class FlightDepatureLoading extends FlightDepatureState {}

class FlightDepatureLoadingSuccess extends FlightDepatureState {
  final List<FlightDepatureResponseModel> response;
  FlightDepatureLoadingSuccess({required this.response});
}

class FlightDepatureLoadingFailure extends FlightDepatureState {
  final String errorMessage;
  FlightDepatureLoadingFailure({required this.errorMessage});
}

