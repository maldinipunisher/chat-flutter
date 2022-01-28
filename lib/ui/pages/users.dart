part of 'pages.dart';

class UsersPage extends StatefulWidget {
  final User user;
  UsersPage(this.user, {Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  bool isLoaded = false;
  List<String> users = [];

  @override
  void initState() {
    users.clear();
    AuthServices.getUsers(widget.user).then((u) {
      setState(() {
        users.addAll(u);
      });
    }).whenComplete(() {
      setState(() {
        isLoaded = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users"), actions: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<PageBloc>(context)
                          .add(GoToRoomPage(widget.user));
                    },
                    icon: const Icon(Icons.message)),
              ],),
      body: (!isLoaded)
          ? const Center(child: SpinKitDualRing(color: Colors.blueAccent))
          : (users.isNotEmpty)
              ? ListView(
                  children: List.generate(
                      users.length,
                      (index) => ListTile(
                            onTap: () {
                              BlocProvider.of<PageBloc>(context)
                                  .add(GoToHomePage(widget.user, users[index]));
                            },
                            title: Text(users[index].toString()),
                          )),
                )
              : const Center(child: Text("No Chat Available")),
    );
  }
}
