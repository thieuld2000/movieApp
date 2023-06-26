import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/src/bloc/watch_moviebloc/watch_movie_bloc.dart';
import 'package:movie_app/src/bloc/watch_moviebloc/watch_movie_bloc_event.dart';
import 'package:movie_app/src/bloc/watch_moviebloc/watch_movie_bloc_state.dart';
import 'package:movie_app/src/model/movie.dart';
import '../widget/horizontal_list_cards.dart';

class BuildWidgetCategory extends StatefulWidget {
  const BuildWidgetCategory({Key? key}) : super(key: key);

  @override
  BuildWidgetCategoryState createState() => BuildWidgetCategoryState();
}

class BuildWidgetCategoryState extends State<BuildWidgetCategory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchMovieBloc>(
          create: (_) =>
              WatchMovieBloc()..add(const WatchMovieEventStarted('')),
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
    List<String> tabs = [
      'Nowplaying',
      'Upcomming',
      'Top rated',
      'Popular',
    ];
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            indicatorColor: Colors.white24,
            indicatorPadding: const EdgeInsets.only(left: 20.0, right: 20.0),
            tabs: tabs
                .map(
                  (tab) => Tab(
                    icon: Text(
                      tab,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 17.0,
                              fontFamily: 'muli',
                              color: Colors.white60),
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width,
            child: TabBarView(children: [
              Tab(child: HorizontalListViewMovies(list: nowPlaying)),
              Tab(child: HorizontalListViewMovies(list: upcoming)),
              Tab(child: HorizontalListViewMovies(list: topRated)),
              Tab(child: HorizontalListViewMovies(list: popular)),
            ]),
          )
        ],
      ),
    );
  }
}
