part of 'pages.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) {
        print(state);
        return (state is OnUsersPage)
            ? UsersPage(state.user)
            : (state is OnRoomPage)
                ? RoomPage(state.user)
                : (state is OnHomePage)
                    ?
                    // RoomPage(state.user)
                    HomePage(state.user, state.to)
                    : const SplashPage();
      },
    );
  }
}
