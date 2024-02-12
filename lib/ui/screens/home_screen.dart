import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_screen_homework/data/network/api_provider.dart';
import 'package:login_screen_homework/data/network/api_repository.dart';
import 'package:login_screen_homework/models/currency_model.dart';
import 'package:login_screen_homework/ui/screens/info_games.dart';
import 'package:login_screen_homework/ui/screens/setting_screens.dart';
import 'package:login_screen_homework/ui/screens/widgets/game_search.dart';

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

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        scrolledUnderElevation: 1,
        elevation: 1,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.indigo
            : Colors.indigo,
        leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
            icon: Icon(CupertinoIcons.bars,
                size: 24.r,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.white)),
        title: Text(
          "Game Store",
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 25.sp,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.white),
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
            icon: Icon(CupertinoIcons.search,
                size: 24.r,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.white),
          ),
        ],
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : currencies.isEmpty
              ? const Center(child: Text("Not Found"))
              : Column(
                  children: [
                    const SizedBox(height: 10),
                    CarouselSlider(
                      items: [
                        ...List.generate(
                          currencies.length,
                          (index) => Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        currencies[index].thumbnail)),
                                borderRadius: BorderRadius.circular(10.r),
                                color: Colors.indigo),
                          ),
                        )
                      ],
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 2),
                      ),
                    ),
                    Text(
                      "All Games",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 24.sp),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          ...List.generate(
                            currencies.length,
                            (index) {
                              CurrencyModel currency = currencies[index];
                              return Container(
                                margin: EdgeInsets.only(
                                    bottom: 10.h, left: 10.w, right: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Material(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.indigo
                                      : Colors.indigo,
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) {
                                            return InfoGames(
                                              app: currencies[index],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      dense: true,
                                      title: Text(
                                        currency.title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.white
                                                    : Colors.white),
                                      ),
                                      subtitle: Text(
                                        currency.title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.white
                                                    : Colors.white),
                                      ),
                                      trailing: Icon(
                                          CupertinoIcons.right_chevron,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.white
                                              : Colors.white),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 250.h),
              child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                      return const SettingsScreen();
                    }));
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                  leading: Icon(CupertinoIcons.settings_solid, size: 24.r),
                  title: Text(
                    "Settings",
                    style:
                        TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
                  ),
                  trailing: Icon(CupertinoIcons.right_chevron, size: 24.r)),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Text("Phantom Games",
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
