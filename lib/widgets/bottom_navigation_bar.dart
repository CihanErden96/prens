
import 'package:prens/widgets/person_list.dart';
import 'package:prens/widgets/department_list.dart';
import 'package:prens/widgets/question_list.dart';
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
                child: widget.selectedIndex == 0
                    ? departmentSelectionList(
                        onSelect: (department) {}, // do nothing
                        enableDeletion: true,
                        enableAdding: true,
                      )
                    : widget.selectedIndex == 2
                        ? PersonSelectionList(
                            onSelect: (person) {}, // do nothing
                            enableDeletion: true,
                            enableAdding: true,
                          )
                        : QuestionSelectionList(
                            onSelect: (person) {}, // do nothing
                            enableDeletion: true,
                            enableAdding: true,
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
                      iconData = Icons.factory;
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
                          if (widget.selectedIndex == index) {
                            widget.onTabChange(-1, false, false, 130.0);
                          } else {
                            widget.onTabChange(index, true, false, 130.0);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: widget.selectedIndex == index ? Colors.white : Theme.of(context).primaryColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              iconData,
                              size: 40,
                              color: widget.selectedIndex == index ? Theme.of(context).primaryColor : Colors.white,
                            ),
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