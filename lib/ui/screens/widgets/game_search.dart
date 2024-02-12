import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_screen_homework/models/currency_model.dart';
import 'package:login_screen_homework/ui/screens/info_games.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class GameSearch extends SearchDelegate {
  GameSearch({required this.suggestionList});

  final List<CurrencyModel> suggestionList;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(CupertinoIcons.clear,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            size: 24.r),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, query);
        },
        icon: Icon(CupertinoIcons.back,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            size: 24.r));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text(query, style: TextStyle(fontSize: 64.sp)));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<CurrencyModel> suggestions = suggestionList.where((searchResult) {
      final result = searchResult.title.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
      children: List.generate(
        suggestions.length,
        (index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.indigo,
          ),
          padding: EdgeInsets.all(8.r),
          margin: EdgeInsets.all(8.r),
          width: double.infinity,
          child: ZoomTapAnimation(
            onTap: () {
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) {
                    return InfoGames(app: suggestions[index]);
                  },
                ),
              );
            },
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: CachedNetworkImage(
                        imageUrl: suggestions[index].thumbnail)),
                SizedBox(height: 10.h),
                Text(
                  suggestions[index].title,
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
