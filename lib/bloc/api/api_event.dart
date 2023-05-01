part of 'api_bloc.dart';

@immutable
abstract class ApiEvent {}

class AllProductsApiEvent extends ApiEvent {}

class FilterProductAPIEvent extends ApiEvent {
  RangeValues sugarValues;
  RangeValues proteinValues ;
  RangeValues carboValues;
  RangeValues fatValues;
  FilterProductAPIEvent({required this.sugarValues, required this.proteinValues, required this.carboValues, required this.fatValues});
}
