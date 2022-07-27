import 'package:chair_app/screens/game_room.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text("Home")),
        body: Center(
          child: Column(
            children: [
              TabBar(tabs: [
                Tab(
                  child: Text(
                    "Game Tab",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    'Credits Tab',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ]),
              Expanded(
                  child: TabBarView(children: [
                Container(
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GameRoomScreen()));
                        },
                        title: Text("Game Room 1"),
                        subtitle: Text('Contestant Count 100'),
                      )
                    ],
                  ),
                ),
                Container(
                  child: SingleChildScrollView(
                      child: Column(
                    children: List.generate(
                        100,
                        (index) => ListTile(
                              title: Text("Contestant No ${index + 1}"),
                              subtitle: Text("Points 10"),
                            )),
                  )),
                )
              ]))
            ],
          ),
        ),
      ),
    ));
  }
}
