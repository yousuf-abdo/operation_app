import 'package:operation_app/features/flight_depature/model/depature_service_request_model.dart';

abstract class DepatureServiceRequestState {}

class DepatureServiceRequestInitial extends DepatureServiceRequestState {}

class DepatureServiceRequestLoading extends DepatureServiceRequestState {}

class DepatureServiceRequestLoadingSuccess extends DepatureServiceRequestState {
  final DepatureServiceRequestModel response;
  DepatureServiceRequestLoadingSuccess({required this.response});
}

class DepatureServiceRequestLoadingFailure extends DepatureServiceRequestState {
  final String errorMessage;
  DepatureServiceRequestLoadingFailure({required this.errorMessage});
}

