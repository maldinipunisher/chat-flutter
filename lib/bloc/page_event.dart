part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();

  @override
  List<Object> get props => [];
}

class GoToHomePage extends PageEvent {
  final User user;
  final String to;
  const GoToHomePage(this.user, this.to);
}

class GoToRoomPage extends PageEvent {
  final User user;
  const GoToRoomPage(this.user);
}

class GoToUsersPage extends PageEvent {
  final User user;
  const GoToUsersPage(this.user);
}

class GoToTestPage extends PageEvent {}
