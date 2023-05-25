import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/movie.dart';

class ViewPhotos extends StatefulWidget {
  final int imageIndex;
  final Color color;
  final List<ImageBackdrop> imageList;
  const ViewPhotos({
    Key? key,
    required this.imageIndex,
    required this.color,
    required this.imageList,
  }) : super(key: key);
  @override
  ViewPhotosState createState() => ViewPhotosState();
}

class ViewPhotosState extends State<ViewPhotos> {
  late PageController pageController;
  late int currentIndex;
  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.imageIndex;
    pageController = PageController(initialPage: widget.imageIndex);
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () =>
                launchUrl(widget.imageList[currentIndex].image as Uri),
            icon: const Icon(
              Icons.open_in_browser,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        pageController: pageController,
        builder: (BuildContext context, int i) {
          return PhotoViewGalleryPageOptions(
            imageProvider:
                CachedNetworkImageProvider(widget.imageList[i].image),
            minScale: PhotoViewComputedScale.contained,
          );
        },
        onPageChanged: onPageChanged,
        itemCount: widget.imageList.length,
        loadingBuilder: (context, progress) => Center(
          child: CircularProgressIndicator(
            color: Colors.cyanAccent,
            strokeWidth: 2,
            backgroundColor: Colors.grey.shade800,
            value: progress == null
                ? null
                : progress.cumulativeBytesLoaded / progress.expectedTotalBytes!,
          ),
        ),
      ),
    );
  }
}
