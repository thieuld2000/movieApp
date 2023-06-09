// ignore_for_file: file_names

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/src/model/movie.dart';
import 'package:movie_app/src/widget/add_button/add_button.dart';

import 'package:readmore/readmore.dart';

import '../../bloc/movie_info_bloc/movie_info_bloc.dart';
import '../../bloc/movie_info_bloc/movie_info_event.dart';
import '../../bloc/movie_info_bloc/movie_info_state.dart';
import '../../widget/animation.dart';
import '../../widget/cast_list.dart';
import '../../widget/constants.dart';
import '../../widget/expandable_group.dart';
import '../../widget/image_view.dart';
import '../../widget/no_results_found.dart';
import '../../widget/star_icon_display.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String id;
  final String backdrop;
  const MovieDetailsScreen({
    Key? key,
    required this.id,
    required this.backdrop,
  }) : super(key: key);

  @override
  MovieDetailsScreenState createState() => MovieDetailsScreenState();
}

class MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieInfoBloc()..add(LoadMoviesInfo(id: widget.id)),
      child: BlocBuilder<MovieInfoBloc, MovieInfoState>(
        builder: (context, state) {
          if (state is MovieInfoLoaded) {
            return MovieDetailScreenWidget(
              info: state.tmdbData,
              backdrops: state.backdrops,
              castList: state.cast,
              imdbInfo: state.imdbData,
              backdrop: widget.backdrop,
            );
          } else if (state is MovieInfoError) {
            return const ErrorPage();
          } else if (state is MovieInfoLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.grey.shade700,
                  strokeWidth: 2,
                  backgroundColor: Colors.cyanAccent,
                ),
              ),
            );
          }
          return const Scaffold();
        },
      ),
    );
  }
}

class MovieDetailScreenWidget extends StatelessWidget {
  final MovieInfoModel info;
  final MovieInfoImdb imdbInfo;
  final List<ImageBackdrop> backdrops;
  final List<CastInfo> castList;
  final String backdrop;
  const MovieDetailScreenWidget({
    Key? key,
    required this.info,
    required this.imdbInfo,
    required this.backdrops,
    required this.castList,
    required this.backdrop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> tabs = [
      'About movie',
      'Reviews',
      'Cast',
    ];
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(info.backdrops.toString()),
            fit: BoxFit.cover,
            alignment: Alignment.topLeft,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 50),
          child: Container(
            color: const Color.fromARGB(255, 32, 32, 33),
            child: Stack(
              children: [
                Column(
                  children: [
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CreateIcons(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(
                                CupertinoIcons.back,
                                color: Colors.white,
                              ),
                            ),
                            AddButton(
                              id: info.tmdbId,
                              title: info.title,
                              rate: info.rateing,
                              poster: info.poster,
                              type: 'movie',
                              date: info.releaseDate,
                              genre: info.genres.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      // onTap: () {
                      //   pushNewScreen(
                      //     context,
                      //     ViewPhotos(
                      //       imageIndex: 0,
                      //       color: Theme.of(context).primaryColor,
                      //       imageList: backdrops,
                      //     ),
                      //   );
                      // },
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * (1 - 0.73),
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          imageUrl: info.backdrops.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 260, left: 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                        imageUrl: info.poster.toString(), width: 110),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 310, left: 340),
                    child: Row(
                      children: [
                        StarDisplay(
                          value: ((info.rateing * 5) / 10).round(),
                        ),
                        Text(
                          "  ${info.rateing}",
                          style: normalText.copyWith(
                            color: Colors.amber[800],
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 370, left: 150, right: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DelayedDisplay(
                          delay: const Duration(microseconds: 700),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: info.title,
                                  style: heading.copyWith(
                                      fontFamily: 'muli',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 450, left: 55),
                  child: Row(children: [
                    Text(
                      " ${info.releaseDate.split("-")[0]}",
                      style:
                          const TextStyle(color: Colors.white60, fontSize: 17),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        '|',
                        style: TextStyle(color: Colors.white60),
                      ),
                    ),
                    Text(
                      '${imdbInfo.runtime}  Minutes',
                      style: normalText.copyWith(color: Colors.white60),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        '|',
                        style: TextStyle(color: Colors.white60),
                      ),
                    ),
                    Text(
                      imdbInfo.genre.split(",")[0].split("(")[1].split(")")[0],
                      style: normalText.copyWith(color: Colors.white60),
                    ),
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 480, left: 30),
                  child: DefaultTabController(
                    initialIndex: 0,
                    length: tabs.length,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        TabBar(
                          isScrollable: true,
                          indicatorColor: Colors.white24,
                          indicatorPadding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
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
                          height: MediaQuery.of(context).size.width / 2 + 30,
                          child: TabBarView(
                            children: [
                              Tab(
                                child: ReadMoreText(
                                  info.overview,
                                  trimLines: 5,
                                  colorClickableText: Colors.pink,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: 'more',
                                  trimExpandedText: 'less',
                                  style: normalText.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  moreStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Tab(
                                child: ExpandableGroup(
                                  isExpanded: true,
                                  items: [
                                    ListTile(
                                        title: Text(
                                          "Runtime",
                                          style: heading.copyWith(
                                              color: Colors.white70,
                                              fontSize: 16),
                                        ),
                                        subtitle: Text(
                                          imdbInfo.runtime,
                                          style: normalText.copyWith(
                                              color: Colors.white60),
                                        )),
                                    ListTile(
                                      title: Text(
                                        "Genres",
                                        style: heading.copyWith(
                                            color: Colors.white70,
                                            fontSize: 16),
                                      ),
                                      subtitle: Text(
                                        imdbInfo.genre,
                                        style: normalText.copyWith(
                                            color: Colors.white60),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Tab(
                                child: CastList(
                                  castList: castList,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreateIcons extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  const CreateIcons({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: kElevationToShadow[2],
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 50),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(.5),
            ),
            child: InkWell(onTap: onTap, child: child),
          ),
        ),
      ),
    );
  }
}
