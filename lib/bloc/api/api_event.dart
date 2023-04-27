part of 'api_bloc.dart';

@immutable
abstract class ApiEvent {}

class AllProductsApiEvent extends ApiEvent {}

class SearchProductAPIEvent extends ApiEvent{
  final String title ;

  SearchProductAPIEvent({required this.title});
}

class FilterProductAPIEvent extends ApiEvent {

}