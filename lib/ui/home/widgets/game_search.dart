import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:login_screen_homework/models/currency_model.dart';
import 'package:login_screen_homework/ui/home/widgets/info_games.dart';
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
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, query);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: const TextStyle(
          fontSize: 64
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<CurrencyModel> suggestions = suggestionList.where((searchResult) {
      final result = searchResult.title.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: List.generate(
          suggestions.length,
          (index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.indigo,
            ),
            
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            child: ZoomTapAnimation(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return InfoGames(app: suggestions[index]);
                    },
                  ),
                );
              },
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(imageUrl: suggestions[index].thumbnail)),
                  const SizedBox(
                    height: 10
                  ),
                  Text(
                    suggestions[index].title,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
