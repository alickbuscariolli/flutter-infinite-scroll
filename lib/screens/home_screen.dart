import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final numbersList = List.generate(20, (index) => Random().nextInt(10));
  final scrollCtrl = ScrollController();

  int page = 1;
  int totalPages = 5;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollCtrl.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollCtrl.offset >= scrollCtrl.position.maxScrollExtent - 50 &&
        page < totalPages &&
        !isLoading) {
      loadMoreNumbers();
    }
  }

  Future<void> loadMoreNumbers() async {
    isLoading = true;

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      numbersList.addAll(List.generate(20, (index) => Random().nextInt(10)));
    });

    page++;

    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          controller: scrollCtrl,
          itemCount: numbersList.length,
          itemBuilder: (_, int index) {
            return Column(
              children: [
                Center(
                  child: Text(
                    numbersList[index].toString(),
                    style: const TextStyle(
                        fontSize: 55, fontWeight: FontWeight.bold),
                  ),
                ),
                if (index == numbersList.length - 1 && page < totalPages) ...[
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(),
                  ),
                ]
              ],
            );
          }),
    );
  }
}
