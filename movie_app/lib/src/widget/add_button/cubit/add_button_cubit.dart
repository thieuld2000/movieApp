import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/movie.dart';
import '../../../service/api_service.dart';

part 'add_button_state.dart';

class AddButtonCubit extends Cubit<AddButtonState> {
  AddButtonCubit() : super(AddButtonState.initial());

  void init(String id) async {
    List<MovieInfoModel> movie;
    movie = await FetchWatchList().getWatchList();
    int index = 0;
    for (index; index < movie.length; index++) {
      if (id == movie[index].imdbid) {
        emit(state.copyWith(isAdd: true));
      }
    }
  }
}
