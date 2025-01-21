import 'package:flutter/material.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:todos/screens/homescreen.dart';
import 'package:todos/screens/auth/loginscreen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<PageData> pages = [
    PageData(
      title: "Organize Your Life",
      description: "Keep track of your tasks and stay productive.",
      backgroundColor: Colors.purple[400]!,
      image: Icons.task_alt,
    ),
    PageData(
      title: "Set Reminders",
      description: "Never miss a deadline or forget important events.",
      backgroundColor: Colors.purple[600]!,
      image: Icons.alarm,
    ),
    PageData(
      title: "Achieve Goals",
      description: "Break your goals into manageable tasks and track progress.",
      backgroundColor: Colors.purple[800]!,
      image: Icons.flag,
    ),
    PageData(
      title: "Get Started Now",
      description: "Start organizing your day with ease and efficiency.",
      backgroundColor: Colors.purple[900]!,
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
                      foregroundColor: Colors.purple, backgroundColor: Colors.white,
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
      MaterialPageRoute(builder: (context) => LoginScreen()),
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
