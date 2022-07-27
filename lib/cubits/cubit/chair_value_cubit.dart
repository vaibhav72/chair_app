import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chair_value_state.dart';

class ChairValueCubit extends Cubit<ChairValueState> {
  final int totalCount;
  final List<int> contestants;
  Timer? timer;
  ChairValueCubit({required this.totalCount, required this.contestants})
      : super(ChairValueInitial());

  getValues() async {
    log("here");
    int currentIndex = 0;
    int nextIndex = 0;
    log("Timer Started");
    if (timer != null) timer!.cancel();
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (contestants.length == 1) {
        timer.cancel();
        emit(ChairNewValue(
            currentList: (state as ChairNewValue).currentList,
            skipValue: 999999,
            winner: true));
      } else {
        List<int> prevList = [];
        prevList.addAll(contestants);
        nextIndex += 1;
        int value = contestants.removeAt(currentIndex);
        if ((currentIndex + nextIndex) < contestants.length) {
          currentIndex += nextIndex;
          log(contestants.toString());
          log("currentIndx $currentIndex nextIndex $nextIndex lenght ${contestants.length}");
        } else {
          log(contestants.toString());
          if (currentIndex > contestants.length) {
            currentIndex = contestants.length - 1;
          }
          // log("currentIndx $currentIndex nextIndex $nextIndex lenght ${contestants.length}");
          int prevIndex = currentIndex;
          currentIndex = ((currentIndex + nextIndex) % (contestants.length));

          log("currentIndx $currentIndex nextIndex $nextIndex lenght ${contestants.length}");
        }
        emit(ChairNewValue(currentList: prevList, skipValue: value));
        log(prevList.contains(value).toString());
        Future.delayed(
            Duration(
              milliseconds: 1000,
            ), () {
          emit(ChairNewValue(currentList: contestants, skipValue: value));
        });

        // log(skipValue.toString());

        // log(contestants.toString());
      }
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close
    if (timer != null) timer!.cancel();
    return super.close();
  }
}


// Imagine that you are in a room with 100 chairs arranged in a circle. These chairs are numbered sequentially from 1 to 100. At some point in time, the person in chair #1 will be told to leave the room. The person in chair #2 will be skipped, and the person in chair #3 will be told to leave. Next to go is person in chair #6. In other words, 1 person will be skipped initially, and then 2, 3, 4.. and so on.
// This pattern of skipping will keep going around the circle until there is only one person remaining - the survivor! Note that each chair is removed when the person leaves the room.
// • Guidelines:
// - Create a launch screen. On launch, open a screen with the tabbed layout with two tabs. On first, show listing of game rooms, whereas on the second, show the credits tab with sample about section with dummy text.
// On the game room listing view, create a default game room card where 100 numbered cards are added depicting each player.
// When user clicks on the game room, start by animating removal of cards in the sequence mentioned in the problem. When the last player is left, highlight the card depicting it as the winner of the game in that game room.
// Sohail Durrani11:54 AM
// - Your design and code should meet these requirements and be sufficiently flexible to allow for future extensibility. Code should be well structured and suitably commented.