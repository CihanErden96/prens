import 'package:flutter/material.dart';
import 'package:prens/global_variables.dart' as globals;
import 'package:percent_indicator/circular_percent_indicator.dart'; // Import percent_indicator

class SwipeToDeletedepartmentItem extends StatefulWidget {
  final String departmentItem;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final bool enableDeletion; // Added enableDeletion flag

  const SwipeToDeletedepartmentItem({
    required this.departmentItem,
    required this.onDelete,
    required this.onTap,
    this.enableDeletion = true, // Default to true
    super.key,
  });

  @override
  State<SwipeToDeletedepartmentItem> createState() => _SwipeToDeletedepartmentItemState();
}

class _SwipeToDeletedepartmentItemState extends State<SwipeToDeletedepartmentItem> with SingleTickerProviderStateMixin {
  double dragExtent = 0.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  }

  void resetPosition() {
    _controller.reverse();
    setState(() {
      dragExtent = 0.0;
    });
  }

  void animateOffscreen() {
    _controller.forward().then((_) {
      widget.onDelete();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Conditionally wrap with GestureDetector for swipe-to-delete
    Widget listItem = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final animationValue = _controller.value;
        return Transform.translate(
          offset: Offset(dragExtent + (animationValue * screenWidth), 0),
          child: child,
        );
      },
      child: InkWell(
        onTap: widget.onTap, // onTap is always available for the list item itself
        child: Container(
          height: 75.0,
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.departmentItem, style: const TextStyle(color: Colors.white)),
              // Replaced Icon with CircularPercentIndicator
              CircularPercentIndicator(
                radius: 25.0, // Adjust size as needed
                lineWidth: 5.0, // Adjust thickness as needed
                percent: 0.75, // Placeholder percentage
                center: Text(
                  "75%", // Placeholder text
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12, // Adjust font size as needed
                    color: Colors.white,
                  ),
                ),
                progressColor: Colors.white,
                backgroundColor: Colors.white24,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ],
          ),
        ),
      ),
    );

    if (widget.enableDeletion) {
      return Stack(
        children: [
          // Show delete icon only when deletion is enabled
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
          ),
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                dragExtent += details.delta.dx;
                // Clamp dragExtent to a maximum value (e.g., 75 pixels) to limit swipe distance
                dragExtent = dragExtent.clamp(0.0, 75.0);
              });
            },
            onHorizontalDragEnd: (details) async {
              // Trigger delete if dragExtent exceeds a smaller threshold (e.g., 50 pixels)
              if (dragExtent > 50.0) {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Fabrikayı Sil'), // Updated dialog title
                      content: Text('${widget.departmentItem} silinsin mi?'), // Updated dialog content
                      actions: [
                        TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Hayır')),
                        TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Evet')),
                      ],
                    );
                  },
                );
                if (confirmed == true) {
                  animateOffscreen();
                } else {
                  resetPosition();
                }
              } else {
                resetPosition();
              }
            },
            child: listItem, // Wrap the list item with GestureDetector
          ),
        ],
      );
    } else {
      return listItem; // Return just the list item if deletion is disabled
    }
  }
}

// ignore: camel_case_types
class departmentSelectionList extends StatefulWidget {
  final void Function(String departmentItem) onSelect;
  final bool enableDeletion; // Added enableDeletion flag
  final bool enableAdding; // Added enableAdding flag

  const departmentSelectionList({
    required this.onSelect,
    this.enableDeletion = true, // Default to true
    this.enableAdding = true, // Default to true
    super.key,
  });

  @override
  State<departmentSelectionList> createState() => _departmentSelectionListState();
}

// ignore: camel_case_types
class _departmentSelectionListState extends State<departmentSelectionList> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _showAdddepartmentDialog(BuildContext context) async { // Renamed function
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Set background color
          title: Text('Yeni Fabrika Ekle', style: TextStyle(color: Theme.of(context).primaryColor)), // Updated title style
          content: TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(hintText: "Fabrika Adı"), // Updated hint text
            style: TextStyle(color: Theme.of(context).primaryColor), // Updated text field style
          ),
          actions: [
            TextButton(
              child: Text('İptal', style: TextStyle(color: Theme.of(context).primaryColor)), // Updated button style
              onPressed: () {
                Navigator.of(context).pop();
                _textEditingController.clear();
              },
            ),
            TextButton(
              child: Text('Ekle', style: TextStyle(color: Theme.of(context).primaryColor)), // Updated button style
              onPressed: () {
                final newdepartment = _textEditingController.text.trim(); // Updated variable name
                if (newdepartment.isNotEmpty) {
                  setState(() {
                    globals.departmentList.add(newdepartment); // Updated to use departmentList
                  });
                }
                Navigator.of(context).pop();
                _textEditingController.clear();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned.fill(
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 70), // Adjusted bottom padding for button
                    itemCount: globals.departmentList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two columns
                      crossAxisSpacing: 8, // Spacing between columns
                      mainAxisSpacing: 0, // Reduced spacing between rows
                      mainAxisExtent: 75.0, // Set item height directly
                    ),
                    itemBuilder: (context, index) {
                      final department = globals.departmentList[index];
                      return SwipeToDeletedepartmentItem(
                        key: ValueKey(department), // Added unique key
                        departmentItem: department,
                        onDelete: () {
                          setState(() {
                            globals.departmentList.removeAt(index);
                          });
                        },
                        onTap: () {
                          widget.onSelect(department);
                        },
                        enableDeletion: widget.enableDeletion,
                      );
                    },
                  ),
                ),
                if (widget.enableAdding)
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Material(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        shape: const CircleBorder(),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(40),
                          onTap: () {
                            _showAdddepartmentDialog(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}