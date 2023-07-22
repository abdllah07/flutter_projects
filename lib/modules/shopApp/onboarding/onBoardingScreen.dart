
import 'package:firstproje/modules/shopApp/login/loginScreen.dart';
import 'package:firstproje/modules/shopApp/shared/network/local/Shopcash_helper.dart';
import 'package:firstproje/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/styles/colors.dart';

class BoardingMode {
  late final String image;
  late final String title;
  late final String body;
  BoardingMode({
    required this.title,
    required this.body,
    required this.image,
  });
}

class onBoardingScreen extends StatefulWidget {
  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  List<BoardingMode> borading = [
    BoardingMode(
        title: "Shop the world's most exquisite treasures, right at your fingertips.",
        body: "Find joy in the little things – shop your heart out",
        image: "assets/images/onboard.jpg"),
    BoardingMode(
        title: "Shop smarter, shop beautifully ",
        body: "a touch of elegance awaits",
        image: "assets/images/onboard.jpg"),
    BoardingMode(
        title: "Your shopping journey, made delightful and enchanting.",
        body: "Step into a world of possibilities, explore and shop effortlessly",
        image: "assets/images/onboard1.jpg"),
  ];

  bool isLastPage = false;
  void submit() {
    ShopCashHelper.saveData(key: "onBoarding", value: true).then((value) {
      if (value) {
        NavigateAndFinish(
          context,
          LoginScreen(),
        );
      }
    });
  }

  var boardController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defualtTextButton(
              function: submit,
              text: "SKIP")
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == borading.length - 1) {
                    setState(() {
                      isLastPage = true;
                    });
                  } else {
                    setState(() {
                      isLastPage = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildbordingItem(borading[index]),
                itemCount: borading.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: borading.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotWidth: 10,
                    dotHeight: 10,
                    expansionFactor: 4,
                    spacing: 5,
                    activeDotColor: defualtColor,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLastPage) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(seconds: 1),
                        curve: Curves.ease,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildbordingItem(BoardingMode model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '${model.body}',
            style: TextStyle(),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      );
}
