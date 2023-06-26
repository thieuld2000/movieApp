import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/src/bloc/moviebloc/movie_bloc.dart';
import 'package:movie_app/src/bloc/moviebloc/movie_bloc_event.dart';
import 'package:movie_app/src/bloc/moviebloc/movie_bloc_state.dart';
import 'package:movie_app/src/ui/category_screen.dart';
import '../model/movie.dart';
import '../model/results/cubit/search_results_cubit.dart';
import '../model/results/search_results.dart';
import '../widget/animation.dart';
import '../widget/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (_) => MovieBloc()..add(const MovieEventStarted(0, '')),
        )
      ],
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(36, 42, 50, 1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'What do you want to watch?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: _buildBody(context),
      ),
    );
  }
}

Widget _buildBody(BuildContext context) {
  return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: constraints.maxHeight),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                right: 17,
                left: 17,
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0.5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 74, 77, 81),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  style: normalText.copyWith(color: Colors.white),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                    hintText: "Search",
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 20,
                    ),
                    hintStyle: TextStyle(
                      letterSpacing: .0,
                      color: Colors.white70.withOpacity(.7),
                    ),
                    fillColor: Colors.grey.withOpacity(.1),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade600,
                        width: .2,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade600,
                        width: .2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade600,
                        width: .2,
                      ),
                    ),
                  ),
                  onSubmitted: (query) {
                    if (query.isNotEmpty) {
                      pushNewScreen(
                          context,
                          BlocProvider(
                            create: (context) =>
                                SearchResultsCubit()..init(query),
                            child: SearchResults(query: query),
                          ));
                    }
                  },
                ),
              ),
            ),
            BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return Center(
                    child: Platform.isAndroid
                        ? const CircularProgressIndicator()
                        : const CupertinoActivityIndicator(),
                  );
                } else if (state is MovieLoaded) {
                  List<Movie> movies = state.movieList;
                  return SizedBox(
                    height: 270,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (BuildContext context, int index) {
                        Movie movie = movies[index];
                        return Container(
                          margin: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: 30,
                          ),
                          width: 170,
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(14)),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'http://image.tmdb.org/t/p/w500/${movie.posterPath}',
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      Platform.isAndroid
                                          ? const CircularProgressIndicator()
                                          : const CupertinoActivityIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/img_not_found.jpg'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  bottom: 15,
                                  left: 15,
                                ),
                              )
                            ],
                          ),
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
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Stack(
                children: const <Widget>[
                  BuildWidgetCategory(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  });
}
