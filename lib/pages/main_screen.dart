import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // Import rendering for ScrollDirection
import '../theme/main_theme.dart';
import 'package:flutter/widgets.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isExpanded = false;
  double _appBarHeight = 130;

  @override
  void initState() {
    super.initState();
    _appBarHeight = 130;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: MainTheme.lightTheme,
      child: Scaffold(
        body: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
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
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: MediaQuery.of(context).padding.top,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                                        title: Text("Logout Confirmation", style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
                                        content: Text("Are you sure you want to logout?", style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text('Body content here'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
