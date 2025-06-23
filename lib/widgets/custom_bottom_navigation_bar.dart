import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final bool isBottomBarRaised;
  final bool isExpanded;
  final double appBarHeight;
  final Function(int, bool, bool, double) onTabChange;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.isBottomBarRaised,
    required this.isExpanded,
    required this.appBarHeight,
    required this.onTabChange,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: widget.isBottomBarRaised ? 500 : 90,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: Offset(0, -2),
          )
        ],
      ),
      child: Stack(
        children: [
          // ListView panel shown when expanded and selection made
          if (widget.isBottomBarRaised && widget.selectedIndex != -1)
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              bottom: 130 + MediaQuery.of(context).viewInsets.bottom, // leave space for icons row and keyboard
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text('Content for index ${widget.selectedIndex}'),
                ),
              ),
            ),

          // Icons row aligned bottom center
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(3, (index) {
                  IconData iconData;
                  switch (index) {
                    case 0:
                      iconData = Icons.factory_rounded;
                      break;
                    case 1:
                      iconData = Icons.notes;
                      break;
                    case 2:
                      iconData = Icons.group_rounded;
                      break;
                    default:
                      iconData = Icons.circle;
                  }
                  return Transform.translate(
                    offset: Offset(0, -20),
                    child: Material(
                      color: Theme.of(context).primaryColor,
                      shape: CircleBorder(),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(40),
                        onTap: () {
                          widget.onTabChange(index, !widget.isBottomBarRaised, false, 130.0);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Icon(
                            iconData,
                            size: 40,
                            color: widget.selectedIndex == index ? Colors.white : Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
