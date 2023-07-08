import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:login_screen_homework/ui/home/widgets/game_search.dart';
import 'package:login_screen_homework/ui/home/widgets/info_games.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../data/network/api_provider.dart';
import '../../data/network/api_repository.dart';
import '../../models/currency_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchText = "";

  final CurrencyRepository currencyRepository =
      CurrencyRepository(apiProvider: ApiProvider());
  List<CurrencyModel> currencies = [];

  bool isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    currencies = await currencyRepository.fetchCurrencies();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: const Text(
          "PHANTOM",
          style: TextStyle(
              fontWeight: FontWeight.w800, fontSize: 25, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              searchText = await showSearch(
                context: context,
                delegate: GameSearch(
                  suggestionList: currencies.map((e) => e).toList(),
                ),
              );
            },
            icon: const Icon(Icons.search, color: Colors.white, size: 30),
          ),
        ],
        centerTitle: true,
      ),
      backgroundColor: Colors.blueGrey,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.indigo,
              ),
            )
          : currencies.isEmpty
              ? const Center(child: Text("Not Found"))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      CarouselSlider(
                        items: [
                          ...List.generate(
                            currencies.length,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              width: 320,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.indigo),
                              child: CachedNetworkImage(
                                  imageUrl: currencies[index].thumbnail),
                            ),
                          )
                        ],
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 1),
                        ),
                      ),
                      const Text(
                        "All Games",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.white),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            ...List.generate(
                              currencies.length,
                              (index) {
                                CurrencyModel currency = currencies[index];
                                return ZoomTapAnimation(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return InfoGames(
                                            app: currencies[index],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    title: Text(
                                      currency.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      currency.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.white),
                                    ),
                                    trailing: const Icon(Icons.arrow_right,color: Colors.white,),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}
