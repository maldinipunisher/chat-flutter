part of 'pages.dart';

class HomePage extends StatefulWidget {
  final User user;
  final String to;
  const HomePage(
    this.user,
    this.to, {
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _messageTextController = TextEditingController();
  // final List messages = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _messageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: StreamBuilder<QuerySnapshot<Map?>>(
            stream: MessageServices.getMessage(widget.user, widget.to),
            builder: (context, asyncSnapshot) {
              return Scaffold(
                backgroundColor: const Color(0xFFE0E0E0),
                appBar: AppBar(
                  title: Text(widget.to),
                ),
                body: (asyncSnapshot.hasError)
                    ? Text('Error: ${asyncSnapshot.error}')
                    : (asyncSnapshot.connectionState == ConnectionState.waiting)
                        ? const Center(
                            child: SpinKitDualRing(color: Colors.blueAccent))
                        : (asyncSnapshot.connectionState ==
                                ConnectionState.none)
                            ? Text("No data")
                            : Stack(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              2 /
                                              100),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                85 /
                                                100,
                                        child: NotificationListener<
                                            OverscrollIndicatorNotification>(
                                          onNotification: (overscroll) {
                                            overscroll.disallowIndicator();
                                            return false;
                                          },
                                          child: ListView(
                                            children: List.generate(
                                              asyncSnapshot.data!.docs.length,
                                              (index) => Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0,
                                                    left: 10,
                                                    right: 10),
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Row(
                                                      mainAxisAlignment: (asyncSnapshot
                                                                      .data!
                                                                      .docs[index]
                                                                      .data()![
                                                                  'to'] ==
                                                              widget.user.uid)
                                                          ? MainAxisAlignment
                                                              .start
                                                          : MainAxisAlignment
                                                              .end,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10,
                                                                  horizontal:
                                                                      20),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: (asyncSnapshot
                                                                            .data!
                                                                            .docs[
                                                                                index]
                                                                            .data()![
                                                                        'to'] ==
                                                                    widget.user
                                                                        .uid)
                                                                ? Colors.white
                                                                : Colors
                                                                    .blueAccent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                          ),
                                                          child: Text(
                                                            asyncSnapshot.data!
                                                                    .docs[index]
                                                                    .data()![
                                                                'message'],
                                                            style: TextStyle(
                                                                color: (asyncSnapshot.data!.docs[index].data()![
                                                                            'to'] ==
                                                                        widget
                                                                            .user
                                                                            .uid)
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .white,
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                              // Text(asyncSnapshot
                                              //     .data!.docs[index]
                                              //     .data()!['message']),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //form input text
                                  SafeArea(
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          controller: _messageTextController,
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: "Enter text...",
                                              suffixIcon: IconButton(
                                                onPressed: () async {
                                                  await MessageServices
                                                      .sendMessage(
                                                          _messageTextController
                                                              .text,
                                                          widget.user,
                                                          widget.to);
                                                  setState(() {
                                                    // messages.add(
                                                    //     _messageTextController
                                                    //         .text);
                                                  });
                                                  _messageTextController
                                                      .clear();
                                                },
                                                icon: const Icon(
                                                  Icons.send,
                                                  color: Colors.blueAccent,
                                                  size: 24,
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
              );
            }),
        onWillPop: () async {
          BlocProvider.of<PageBloc>(context).add(GoToUsersPage(widget.user));
          return false;
        });
  }
}
