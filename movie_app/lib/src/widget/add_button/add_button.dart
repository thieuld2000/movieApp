import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/api_service.dart';
import 'cubit/add_button_cubit.dart';

class AddButton extends StatelessWidget {
  final String id;
  final String date;
  final String title;
  final String poster;
  final String type;
  final double rate;
  final String genre;
  const AddButton({
    Key? key,
    required this.id,
    required this.date,
    required this.title,
    required this.poster,
    required this.type,
    required this.rate,
    required this.genre,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddButtonCubit()..init(id),
      child: BlocBuilder<AddButtonCubit, AddButtonState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ClipRRect(
              child: Container(
                padding: const EdgeInsets.all(0),
                decoration: const BoxDecoration(
                    // color: Colors.black.withOpacity(.5),
                    ),
                child: InkWell(
                  onTap: () async {
                    await WatchLitsPost().postwatchlist(id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        !state.isAdd
                            ? const Icon(
                                CupertinoIcons.bookmark_fill,
                                color: Colors.white,
                                size: 30,
                              )
                            : const Icon(
                                CupertinoIcons.bookmark_fill,
                                color: Colors.amber,
                                size: 30,
                              ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
