import 'package:flutter/material.dart';
import '../widgets/denetim_card.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../constants/global_variables.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isExpanded = false;
  double _appBarHeight = 130;
  bool _isBottomBarRaised = false;
  int _selectedIndex = -1;
  List<String> notes = ["Not 1", "Not 2", "Not 3", "Not 4"];
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
      data: Theme.of(context),
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
                      duration: const Duration(milliseconds: 300),
                      height: _appBarHeight,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary, // Temadan alınan renk ile güncellendi
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.onSurface
                                .withOpacity(
                                  0.5,
                                ), // Temadan alınan renk ile güncellendi
                            blurRadius: 12,
                            offset: const Offset(0, 4),
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: SizedBox(
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      radius: 28,
                                      backgroundImage: NetworkImage(
                                        'https://picsum.photos/200',
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hoşgeldin,',
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onPrimary,
                                            fontSize: 14,
                                          ), // Temadan alınan renk ile güncellendi
                                        ),
                                        Text(
                                          'Cihan',
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onPrimary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ), // Temadan alınan renk ile güncellendi
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        Icons.logout,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onPrimary,
                                      ), // Temadan alınan renk ile güncellendi
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                "Logout Confirmation",
                                                style: TextStyle(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.onSurface,
                                                ),
                                              ),
                                              content: Text(
                                                "Are you sure you want to logout?",
                                                style: TextStyle(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.onSurface,
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                      color: Theme.of(
                                                        context,
                                                      ).colorScheme.primary,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text(
                                                    "Logout",
                                                    style: TextStyle(
                                                      color: Theme.of(
                                                        context,
                                                      ).colorScheme.primary,
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();
                                                    await authService
                                                        ?.signOut();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 16),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Visibility(
                              visible: _isExpanded,
                              maintainState: true,
                              maintainAnimation: true,
                              maintainSize: true,
                              maintainInteractivity: false,
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
                      padding: const EdgeInsets.all(16),
                      children: const [DenetimCard()],
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
