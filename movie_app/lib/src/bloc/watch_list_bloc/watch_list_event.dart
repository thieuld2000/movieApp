import 'package:equatable/equatable.dart';

abstract class WatchListEvent extends Equatable {
  const WatchListEvent();
}

class WatchListEventStarted extends WatchListEvent {
  const WatchListEventStarted();

  @override
  List<Object> get props => [];
}
