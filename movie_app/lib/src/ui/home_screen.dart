import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/src/bloc/moviebloc/movie_bloc.dart';
import 'package:movie_app/src/bloc/moviebloc/movie_bloc_event.dart';
import 'package:movie_app/src/bloc/moviebloc/movie_bloc_state.dart';
import '../model/movie.dart';

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
        backgroundColor: Colors.black45,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'What do you want to watch?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w300,
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
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider.builder(
                            itemCount: movies.length,
                            itemBuilder: (context, int index, int realIndex) {
                              Movie movie = movies[index];
                              return Stack(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Platform
                                              .isAndroid
                                          ? const CircularProgressIndicator()
                                          : const CupertinoActivityIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/img_not_found.jpg'),
                                        )),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                            options: CarouselOptions(
                              enableInfiniteScroll: true,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(microseconds: 500),
                              pauseAutoPlayOnTouch: true,
                              viewportFraction: 0.8,
                              enlargeCenterPage: true,
                            ))
                      ],
                    );
                  } else {
                    return const Text('Something went wrong!!!');
                  }
                },
              )
            ]),
      ),
    );
  });
}
