import 'package:floating_action_bubble_demo/floating_action_bubble.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Action Bubble Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Action Bubble Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Animation<double>? _animation;
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animationController.addListener(() {
      setState(() {});
    });
    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOutBack,
      parent: _animationController,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: const Center(child: Text('')),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: SizedBox(
          height: 50,
          width: 50,
          child: FloatingActionBubbleDemo(
            gap: 7,
            items: <Bubble>[
              Bubble(
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.settings,
                onPress: () {
                  _animationController.reverse();
                },
              ),
              // Floating action menu item
              Bubble(
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.people,
                onPress: () {
                  _animationController.reverse();
                },
              ),
              //Floating action menu item
              Bubble(
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.home,
                onPress: () {
                  _animationController.reverse();
                },
              ),
              //Floating action menu item
              Bubble(
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.person,
                onPress: () {
                  _animationController.reverse();
                },
              ),
              //Floating action menu item
              Bubble(
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.timelapse,
                onPress: () {
                  _animationController.reverse();
                },
              ),
            ],

            // animation controller
            animation: _animation!,

            // On pressed change animation state
            onPress: () => _animationController.isCompleted
                ? _animationController.reverse()
                : _animationController.forward(),

            // Floating Action button Icon color
            iconColor: Colors.blue,
            iconData: Icons.ac_unit,
            backGroundColor: Colors.white,
          ),
        ));
  }
}
