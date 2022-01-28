part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();

  @override
  List<Object> get props => [];
}

class PageInitial extends PageState {}

class OnHomePage extends PageState {
  final User user;
  final String to;
  const OnHomePage(this.user, this.to);
}

class OnRoomPage extends PageState {
  final User user;
  const OnRoomPage(this.user);
}

class OnUsersPage extends PageState {
  final User user;
  const OnUsersPage(this.user);
}

class OnTestPage extends PageState {}
