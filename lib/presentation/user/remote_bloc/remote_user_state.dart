part of 'remote_user_bloc.dart';

sealed class RemoteUserState extends Equatable {

  final UserModel? user;
  final DioException? error;
  final int statusCode;
  final String? id;

  const RemoteUserState({this.user, this.error, this.statusCode = 0, this.id});
  
  @override
  List<Object?> get props => [user, error, statusCode];
}

final class RemoteUserInitial extends RemoteUserState {
  const RemoteUserInitial(String id) : super(id: id);
}

final class RemoteUserLoading extends RemoteUserState {}

final class RemoteUserLoaded extends RemoteUserState {
  const RemoteUserLoaded(int statusCode, UserModel user) : super(statusCode: statusCode, user: user);

  @override
  List<Object?> get props => [statusCode, user];
}

final class RemoteUserError extends RemoteUserState {
  const RemoteUserError(int statusCode, DioException error) : super(statusCode: statusCode, error: error);

  @override
  List<Object?> get props => [statusCode, error];
}

