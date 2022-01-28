part of 'pages.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: SizedBox(
          height: 40,
          width: 200,
          child: RaisedButton(
            elevation: 0,
            onPressed: () async {
              final user = await AuthServices.login(LoginType.anonymous);
              BlocProvider.of<PageBloc>(context).add(GoToUsersPage(user.user!));
            },
            child: const Text("Login Anonymous"),
          ),
        ),
      ),
    );
  }
}
