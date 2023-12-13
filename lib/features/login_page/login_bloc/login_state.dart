import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class InitialAuthState extends AuthState {}

class LoadingState extends AuthState {}

class AuthenticatedState extends AuthState {}

class FailureState extends AuthState {
  
  final String error;

  const FailureState({required this.error});

  @override
  List<Object> get props => [error];
}
