import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/src/bloc/watch_moviebloc/watch_movie_bloc.dart';
import 'package:movie_app/src/bloc/watch_moviebloc/watch_movie_bloc_event.dart';
import 'package:movie_app/src/bloc/watch_moviebloc/watch_movie_bloc_state.dart';
import 'package:movie_app/src/model/movie.dart';

import '../widget/animation.dart';
import '../widget/header_text.dart';
import '../widget/horizontal_list_cards.dart';
import '../widget/movie_home.dart';

class BuildWidgetCategory extends StatefulWidget {
  final int selectedMovie;
  const BuildWidgetCategory({Key? key, this.selectedMovie = 2})
      : super(key: key);

  @override
  BuildWidgetCategoryState createState() => BuildWidgetCategoryState();
}

class BuildWidgetCategoryState extends State<BuildWidgetCategory> {
  late int selectedMovie;

  @override
  void initState() {
    super.initState();
    selectedMovie = widget.selectedMovie;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchMovieBloc>(
          create: (_) =>
              WatchMovieBloc()..add(WatchMovieEventStarted(selectedMovie)),
        ),
      ],
      child: _buildWatchMovie(context),
    );
  }
}

Widget _buildWatchMovie(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      BlocBuilder<WatchMovieBloc, WatchMovieState>(builder: (context, state) {
        if (state is WatchMovieLoading) {
          return Center(
            child: Platform.isAndroid
                ? const CircularProgressIndicator()
                : const CupertinoActivityIndicator(),
          );
        } else if (state is WatchMovieLoaded) {
          return CategoryScreenWidget(
              topRated: state.movieTopRateList,
              upcoming: state.movieUpcomingList,
              popular: state.moviePopularList,
              nowPlaying: state.movieNowPlayingList);
        } else {
          return Container();
        }
      })
    ],
  );
}

class CategoryScreenWidget extends StatelessWidget {
  final List<Movie> popular;
  final List<Movie> topRated;
  final List<Movie> upcoming;
  final List<Movie> nowPlaying;

  const CategoryScreenWidget({
    Key? key,
    required this.popular,
    required this.topRated,
    required this.upcoming,
    required this.nowPlaying,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderText(text: 'Popular'),
              HorizontalListViewMovies(
                list: popular,
              ),
              const HeaderText(text: "Top Rated"),
              HorizontalListViewMovies(
                list: topRated,
              ),
              const SizedBox(
                height: 14,
              ),
              const HeaderText(text: "Upcoming"),
              HorizontalListViewMovies(
                list: upcoming,
              ),
              const SizedBox(
                height: 14,
              ),
              const HeaderText(text: "Now playing"),
              HorizontalListViewMovies(
                list: nowPlaying,
              )
            ],
          ),
        ),
      );
    });
  }
}
