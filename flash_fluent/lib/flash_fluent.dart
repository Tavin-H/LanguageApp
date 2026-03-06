import 'package:flash_fluent/screens/home_screen.dart';
import 'package:flash_fluent/utils/app_actions.dart';
import 'package:flutter/material.dart';

class FlashFluent extends StatefulWidget {
  const FlashFluent({super.key});

  @override
  State<FlashFluent> createState() => _FlashFluentState();
}

class _FlashFluentState extends State<FlashFluent> {
	Widget? activeScreen;
	AppActions? appActions;
	void goToHome() {
		setState(() {
				  activeScreen = HomeScreen(actions: appActions,);
				});
	}
	@override
	  void initState() {
		appActions = AppActions(goToHome: goToHome);
		setState(() {
				  activeScreen = HomeScreen(actions: appActions,);
				});
	    super.initState();
	  }
  @override
  Widget build(BuildContext context) {
    return Container(
			child: activeScreen!,
		);
  }
}

