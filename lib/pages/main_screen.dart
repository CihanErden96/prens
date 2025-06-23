import 'package:flutter/material.dart';
// Import rendering for ScrollDirection
import '../theme/main_theme.dart';
import '../widgets/denetim_card.dart';
import '../widgets/bottom_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isExpanded = false;
  double _appBarHeight = 130;
  bool _isBottomBarRaised = false;
  int _selectedIndex = -1;
  List<String> notes = [
    "Not 1",
    "Not 2",
    "Not 3",
    "Not 4",
  ];
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _appBarHeight = 130;
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Theme(
      data: MainTheme.lightTheme,
      child: Scaffold(
        body: Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  _isBottomBarRaised = false;
                  _selectedIndex = -1;
                });
              },
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        // Collapse bottom bar when app bar is tapped
                        _isBottomBarRaised = false;
                        _selectedIndex = -1;
                        _isExpanded = !_isExpanded;
                        _appBarHeight = _isExpanded ? 500 : 130;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: _appBarHeight,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: MediaQuery.of(context).padding.top,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: SizedBox(
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 28,
                                      backgroundImage: NetworkImage('https://picsum.photos/200'),
                                    ),
                                    SizedBox(width: 12),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hoşgeldin,',
                                          style: TextStyle(color: Colors.white, fontSize: 14),
                                        ),
                                        Text(
                                          'Cihan',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(Icons.logout, color: Colors.white),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Logout Confirmation", style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
                                              content: Text("Are you sure you want to logout?", style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text("Cancel", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text("Logout", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(width: 16),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: AnimatedOpacity(
                              opacity: _isExpanded ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 300),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/saka.png',
                                  width: 350,
                                  height: 300,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.all(16),
                      children: [
                        DenetimCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          isBottomBarRaised: _isBottomBarRaised,
          isExpanded: _isExpanded,
          appBarHeight: _appBarHeight,
          onTabChange: (index, isBottomBarRaised, isExpanded, appBarHeight) {
            setState(() {
              _selectedIndex = index;
              _isBottomBarRaised = isBottomBarRaised;
              _isExpanded = isExpanded;
              _appBarHeight = appBarHeight;
            });
          },
        ),
      ),
    );
  }
}
