import 'package:flutter/material.dart';
import 'package:movie_app/src/model/movie.dart';

import '../ui/movie_info_screen/movie_Info_screen.dart';
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
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SizedBox(
          height: 400,
          child: GridView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75),
            children: [
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
                    pushNewScreen(
                      context,
                      MovieDetailsScreen(
                        id: list[i].id.toString(),
                        backdrop: list[i].backdropPath.toString(),
                      ),
                    );
                  },
                )
            ],
          ),
        ));
  }
}
