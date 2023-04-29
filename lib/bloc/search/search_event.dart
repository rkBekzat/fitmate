part of 'search_bloc.dart';

abstract class SearchEvent {}

class EmptySearchEvent extends SearchEvent {}

class SearchProductEvent extends SearchEvent {
  final String name;

  SearchProductEvent({required this.name});
}
