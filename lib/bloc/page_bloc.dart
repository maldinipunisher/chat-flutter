import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(PageInitial()) {
    on<PageEvent>((event, emit) {});
    on<GoToRoomPage>((event, emit) => emit(OnRoomPage(event.user)));
    on<GoToUsersPage>((event, emit) => emit(OnUsersPage(event.user)));
    on<GoToHomePage>((event, emit) => emit(OnHomePage(event.user, event.to)));
    //TEST
    on<GoToTestPage>((event, emit) => emit(OnTestPage()));
  }
}
