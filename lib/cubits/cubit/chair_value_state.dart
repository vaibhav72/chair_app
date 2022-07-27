part of 'chair_value_cubit.dart';

abstract class ChairValueState extends Equatable {
  const ChairValueState();

  @override
  List<Object> get props => [];
}

class ChairValueInitial extends ChairValueState {}

class ChairNewValue extends ChairValueState {
  int skipValue;
  bool winner;
  List<int> currentList;
  ChairNewValue(
      {required this.currentList,
      required this.skipValue,
      this.winner = false});
  @override
  List<Object> get props => [currentList, skipValue];
}
