import 'package:flutter/material.dart';
import 'package:movie_app/src/model/movie.dart';

import 'animation.dart';
import 'movie_card.dart';

class HorizontalListViewMovies extends StatelessWidget {
  final List<Movie> list;
  final Color? color;
  const HorizontalListViewMovies({
    Key? key,
    required this.list,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 310,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            const SizedBox(
              width: 200,
            ),
            for (var i = 0; i < list.length; i++)
              MovieCard(
                isMovie: true,
                id: list[i].id.toString(),
                name: list[i].title.toString(),
                backdrop: list[i].backdropPath.toString(),
                poster: list[i].posterPath.toString(),
                color: color == null ? Colors.white : color!,
                date: list[i].releaseDate.toString(),
                onTap: () {
                  // pushNewScreen(
                  //   context,
                  //   MovieDetailsScreen(
                  //     id: list[i].id,
                  //     backdrop: list[i].backdrop,
                  //   ),
                  // );
                },
              )
          ],
        ));
  }
}
