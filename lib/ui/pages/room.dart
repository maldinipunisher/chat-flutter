part of 'pages.dart';

class RoomPage extends StatefulWidget {
  final User user;
  RoomPage(this.user, {Key? key}) : super(key: key);

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  List rooms = [];
  bool isLoaded = false;

  @override
  void initState() {
    rooms.clear();
    MessageServices.getContacts(widget.user).then((contacts) {
      MessageServices.getRooms(widget.user, contacts).then((r) {
        setState(() {
          rooms.addAll(r);
        });
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
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PageBloc>(context).add(GoToUsersPage(widget.user));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Chats")),
        body: (!isLoaded)
            ? const Center(child: SpinKitDualRing(color: Colors.blueAccent))
            : (rooms.isNotEmpty)
                ? ListView(
                    children: List.generate(
                        rooms.length,
                        (index) => ListTile(
                              onTap: () {
                                BlocProvider.of<PageBloc>(context).add(
                                    GoToHomePage(widget.user, rooms[index]));
                              },
                              title: Text(rooms[index].toString()),
                            )),
                  )
                : const Center(child: Text("No Chat Available")),
      ),
    );
  }
}
