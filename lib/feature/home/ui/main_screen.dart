import 'package:brain_wave_2/feature/news/ui/news.dart';
import 'package:brain_wave_2/feature/profie/ui/profile_screen.dart';
import 'package:brain_wave_2/feature/user_chats/ui/rooms_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../neurons/ui/neurons_screen.dart';
import '../bloc/navigation_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _widgetOptions = <Widget>[
    const NewsScreen(),
    const NeuronsScreen(),
    const RoomsPage(),
    const Profile(),
  ];

  int _selectedTab = 3;

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state is ViewProfileState) onSelectTab(3);
      },
      builder: (context, state) {
        return WillPopScope(
          child: Scaffold(
            body: Center(
              child: _widgetOptions[_selectedTab],
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),

              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.white,
                //backgroundColor: Colors.black,
                currentIndex: _selectedTab,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.newspaper_outlined),
                    activeIcon: Icon(Icons.newspaper),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.sentiment_neutral_sharp),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.mail_outline),
                    activeIcon: Icon(Icons.mail),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_2_outlined),
                    activeIcon: Icon(Icons.person),
                    label: '',
                  ),
                ],
                onTap: onSelectTab,
              ),
            ),
          ),
          onWillPop: () async => false,
        );
      },
    );
  }
}
