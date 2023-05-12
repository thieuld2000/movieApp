import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    // handleUniLinks();
    super.initState();
  }

  // void handleUniLinks() async {
  //   try {
  //     final initialLink = await getInitialLink();
  //     if (initialLink != null) {
  //       var link = initialLink
  //           .replaceFirst("https://anshrathod.vercel.app/moviedb?id=", "")
  //           .trim();
  //       var id = link.split("-")[0];
  //       var type = link.split("-")[1];
  //       if (type == "movie") {
  //         pushNewScreen(
  //           context,
  //           MovieDetailsScreen(
  //             id: id,
  //             backdrop: '',
  //           ),
  //         );
  //       } else if (type == "tv") {
  //         pushNewScreen(
  //           context,
  //           TvShowDetailScreen(id: id, backdrop: ''),
  //         );
  //       } else if (type == 'cast') {
  //         pushNewScreen(
  //           context,
  //           CastInFoScreen(
  //             id: id,
  //             backdrop: '',
  //           ),
  //         );
  //       } else if (type == 'season') {
  //         var snum = link.split("-")[2];
  //         pushNewScreen(
  //           context,
  //           SeasonDetailScreen(
  //             id: id,
  //             backdrop: '',
  //             snum: snum,
  //           ),
  //         );
  //       }
  //     }
  //     // ignore: empty_catches
  //   } on Exception {}
  // }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    buildCurrentPage(int i) {
      switch (i) {
        case 0:
          return const HomeScreen();

        case 1:
        // return const SearchPage();
        case 2:
        // return const FavoriteScreen();
        default:
          return Container();
      }
    }

    return Scaffold(
      body: buildCurrentPage(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        // border: Border(
        //   top: BorderSide(
        //     color: Colors.grey.shade800,
        //     width: .4,
        //   ),
        // ),
        backgroundColor: const Color.fromRGBO(36, 42, 50, 1),
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        iconSize: 26.0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.home,
              color: Colors.white54,
            ),
            activeIcon: Icon(
              CupertinoIcons.house_fill,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.search,
              color: Colors.white54,
            ),
            activeIcon: Icon(
              CupertinoIcons.search,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.heart,
              color: Colors.white54,
            ),
            label: 'Favorites',
            activeIcon: Icon(
              CupertinoIcons.heart_solid,
            ),
          ),
        ],
      ),
    );
  }
}
