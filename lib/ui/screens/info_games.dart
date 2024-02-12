import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_screen_homework/data/network/api_provider.dart';
import 'package:login_screen_homework/data/network/api_repository.dart';
import 'package:login_screen_homework/models/currency_model.dart';

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
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.indigo
            : Colors.indigo,
        title: Text(
          "Info Games",
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
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
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: CachedNetworkImage(imageUrl: widget.app.thumbnail)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
              child: Text(
                widget.app.title,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24.sp,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white),
              ),
            ),
            RichText(
              text: TextSpan(
                  text: "Company: ",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white),
                  children: [
                    TextSpan(
                      text: widget.app.publisher,
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                    ),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: RichText(
                text: TextSpan(
                    text: "Genre: ",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white),
                    children: [
                      TextSpan(
                        text: widget.app.genre,
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white),
                      ),
                    ]),
              ),
            ),
            RichText(
              text: TextSpan(
                  text: "Support Platform: ",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white),
                  children: [
                    TextSpan(
                      text: widget.app.platform,
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                    ),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: RichText(
                text: TextSpan(
                    text: "Release date: ",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white),
                    children: [
                      TextSpan(
                        text: widget.app.releaseDate,
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white),
                      ),
                    ]),
              ),
            ),
            RichText(
              text: TextSpan(
                  text: "Description: ",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white),
                  children: [
                    TextSpan(
                      text: widget.app.shortDescription,
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                    ),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: GestureDetector(
                onTap: () {
                  FlutterClipboard.copy(widget.app.freetogameProfileUrl)
                      .then((value) {
                    Fluttertoast.showToast(
                      msg: "Copied",
                      toastLength: Toast.LENGTH_LONG,
                      fontSize: 16.sp,
                    );
                  });
                },
                child: RichText(
                  text: TextSpan(
                      text: "Link to Download: ",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                      children: [
                        TextSpan(
                          text: widget.app.freetogameProfileUrl,
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
