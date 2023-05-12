// import 'dart:developer';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movie_app/src/bloc/categorybloc/category_event.dart';
// import 'package:movie_app/src/bloc/categorybloc/category_state.dart';

// class FetchCategoryBloc extends Bloc<FetchCategoryEvent, FetchCategoryState> {
//   final Service repo = Service();

//   FetchCategoryBloc() : super(FetchCategoryInitial()) {
//     on<FetchCategoryEvent>((event, emit) async {
//       if (event is FetchCategoryData) {
//         emit(FetchCategoryLoading());
//         try {
//           final data = await repo.getCategoryPageMovies();
//           emit(FetchCategoryLoaded(
//             tranding: data[0],
//             upcoming: data[3],
//             nowPlaying: data[1],
//             topRated: data[2],
//           ));
//         } on FetchDataError catch (e) {
//           emit(FetchCategoryError(error: e));
//         } catch (e) {
//           emit(FetchCategoryError(error: FetchDataError('something went wrong')));
//         }
//       }
//     });
//   }
// }