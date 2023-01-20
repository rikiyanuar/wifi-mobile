import 'package:flutter_libraries/libraries.dart';

abstract class GeneralState extends Equatable {
  @override
  List<Object> get props => [];
}

class GeneralSuccessState extends GeneralState {
  // ignore: no-object-declaration
  final Object? object;

  GeneralSuccessState({this.object});
}

class GeneralNetworkErrorState extends GeneralState {}

class GeneralErrorState extends GeneralState {
  final String? message;

  GeneralErrorState({this.message});
}

class GeneralErrorSpecificState extends GeneralState {
  final String? message;

  GeneralErrorSpecificState({this.message});
}
