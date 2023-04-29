part of 'api_bloc.dart';

@immutable
abstract class ApiEvent {}

class AllProductsApiEvent extends ApiEvent {}

class FilterProductAPIEvent extends ApiEvent {

}