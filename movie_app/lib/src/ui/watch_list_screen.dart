import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/src/bloc/watch_list_bloc/watch_list_state.dart';

import '../bloc/watch_list_bloc/watch_list_bloc.dart';
import '../bloc/watch_list_bloc/watch_list_event.dart';
import '../model/movie.dart';
import '../widget/movie_card.dart';
import 'movie_info_screen/movie_Info_screen.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchListBloc>(
          create: (_) => WatchListBloc()..add(const WatchListEventStarted()),
        )
      ],
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(36, 42, 50, 1),
        body: _buildBody(context),
      ),
    );
  }
}

Widget _buildBody(BuildContext context) {
  return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(
              top: 50,
              left: 25,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    // CreateIcons(
                    //   onTap: () => Navigator.pop(context),
                    //   child: const Icon(
                    //     CupertinoIcons.back,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(left: 155),
                      child: Text(
                        'Watch List',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 19),
                      ),
                    )
                  ],
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxHeight),
                  child: Column(children: <Widget>[
                    BlocBuilder<WatchListBloc, WatchListState>(
                      builder: (context, state) {
                        if (state is WatchListLoading) {
                          return Center(
                            child: Platform.isAndroid
                                ? const CircularProgressIndicator()
                                : const CupertinoActivityIndicator(),
                          );
                        } else if (state is WatchListLoaded) {
                          List<MovieInfoModel> movies = state.movieWatchList;

                          return Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: movies.length,
                              itemBuilder: (BuildContext context, int index) {
                                MovieInfoModel movie = movies[index];
                                return HorizontalMovieCard(
                                  poster: movie.poster,
                                  name: movie.title,
                                  backdrop: '',
                                  date: movie.releaseDate.toString() != ''
                                      ? " ${movie.releaseDate.split("-")[0]}"
                                      : "Not Available",
                                  id: movie.imdbid,
                                  color: Colors.white,
                                  isMovie: true,
                                  rate: movie.rateing,
                                );
                              },
                            ),
                          );
                        } else {
                          return const Text(
                            'Something went wrong!!!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          );
                        }
                      },
                    ),
                  ]),
                ),
              ],
            )));
  });
}
