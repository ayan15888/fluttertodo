import 'package:flutter/material.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:todos/screens/homescreen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<PageData> pages = [
    PageData(
      title: "Welcome",
      description: "Discover amazing features with our app.",
      backgroundColor: Colors.blueAccent,
      image: Icons.explore,
    ),
    PageData(
      title: "Stay Connected",
      description: "Connect with your friends and family instantly.",
      backgroundColor: const Color.fromARGB(255, 246, 32, 178),
      image: Icons.chat,
    ),
    PageData(
      title: "Get Started",
      description: "Let's get started with your journey.",
      backgroundColor: Colors.blue,
      image: Icons.rocket_launch,
    ),
    PageData(
      title: " Started",
      description: "Let's get started with your journey.",
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      image: Icons.rocket_launch,
    ),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ConcentricPageView(
            colors: pages.map((p) => p.backgroundColor).toList(),
            itemCount: pages.length,
            itemBuilder: (int index) {
              final page = pages[index];
              return PageCard(data: page);
            },
            onFinish: () {
              navigateToHome(context);
            },
            onChange: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          // Skip and Done buttons
          Positioned(
            bottom: 30,
            left: 20,
            child: currentIndex < pages.length - 1
                ? TextButton(
                    onPressed: () => navigateToHome(context),
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ),
          Positioned(
            bottom: 30,
            right: 20,
            child: currentIndex == pages.length - 1
                ? ElevatedButton(
                    onPressed: () => navigateToHome(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blue, backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Done",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : SizedBox.shrink(),
          ),
          // Page indicator
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => buildDot(index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Homescreen()),
    );
  }

  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: currentIndex == index ? 20 : 10,
      decoration: BoxDecoration(
        color: currentIndex == index ? Colors.white : Colors.white54,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class PageData {
  final String title;
  final String description;
  final Color backgroundColor;
  final IconData image;

  PageData({
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.image,
  });
}

class PageCard extends StatelessWidget {
  final PageData data;

  const PageCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          data.image,
          size: 100,
          color: Colors.white,
        ),
        SizedBox(height: 20),
        Text(
          data.title,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            data.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }
}

