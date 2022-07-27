import 'package:chair_app/cubits/cubit/chair_value_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameRoomScreen extends StatefulWidget {
  const GameRoomScreen({Key? key}) : super(key: key);

  @override
  State<GameRoomScreen> createState() => _GameRoomScreenState();
}

class _GameRoomScreenState extends State<GameRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChairValueCubit(
          totalCount: 10, contestants: List.generate(10, (index) => index + 1))
        ..getValues(),
      child: BlocConsumer<ChairValueCubit, ChairValueState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ChairNewValue) {
            return Scaffold(
                appBar: AppBar(title: Text("Game Screen")),
                body: Center(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 10),
                        itemCount: state.currentList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: GameTile(
                              key:
                                  ValueKey(state.currentList[index].toString()),
                              value: state.currentList[index],
                              deleted:
                                  state.currentList[index] == state.skipValue,
                              winner: state.currentList.length == 1,
                            ),
                          );
                        })));
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class GameTile extends StatefulWidget {
  GameTile({
    Key? key,
    required this.value,
    required this.winner,
    required this.deleted,
  }) : super(key: key);
  int value;
  bool winner;
  bool deleted;
  @override
  State<GameTile> createState() => _GameTileState();
}

class _GameTileState extends State<GameTile>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..forward();
  }

  @override
  void dispose() {
    controller.animateBack(0);
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: Tween<double>(begin: .3, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.easeInOut,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: !widget.deleted
                  ? widget.winner
                      ? Colors.green
                      : Colors.white
                  : Colors.red,
              borderRadius: BorderRadius.circular(9)),
          width: MediaQuery.of(context).size.width * .08,
          height: 60,
          child: Center(child: Text(widget.value.toString())),
        ));
  }
}
