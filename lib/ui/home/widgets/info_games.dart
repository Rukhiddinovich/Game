import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:login_screen_homework/ui/home/home_screen.dart';

import '../../../data/network/api_provider.dart';
import '../../../data/network/api_repository.dart';
import '../../../models/currency_model.dart';

class InfoGames extends StatefulWidget {
  const InfoGames({super.key, required this.app});

  final CurrencyModel app;

  @override
  State<InfoGames> createState() => _InfoGamesState();
}

class _InfoGamesState extends State<InfoGames> {
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
        ),
        title: const Text(
          "Info Games",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.blueGrey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: 320,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.indigo),
                  child: CachedNetworkImage(imageUrl: widget.app.thumbnail)),
            ),
            const SizedBox(height: 10),
            Text(
              widget.app.title,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Colors.white),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                  text: "Company: ",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  children: [
                    TextSpan(
                      text: widget.app.publisher,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ]),
            ),
            RichText(
              text: TextSpan(
                  text: "Genre: ",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  children: [
                    TextSpan(
                      text: widget.app.genre,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ]),
            ),
            RichText(
              text: TextSpan(
                  text: "Support Platform: ",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  children: [
                    TextSpan(
                      text: widget.app.platform,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ]),
            ),
            RichText(
              text: TextSpan(
                  text: "Release date: ",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  children: [
                    TextSpan(
                      text: widget.app.releaseDate,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ]),
            ),
            RichText(
              text: TextSpan(
                  text: "Description: ",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  children: [
                    TextSpan(
                      text: widget.app.shortDescription,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ]),
            ),
            RichText(
              text: TextSpan(
                  text: "Link to Download: ",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  children: [
                    TextSpan(
                      text: widget.app.freetogameProfileUrl,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
