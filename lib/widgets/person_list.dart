import 'package:flutter/material.dart';
import 'package:prens/constants/global_variables.dart' as globals;
class SwipeToDeleteItem extends StatefulWidget {
  final String person;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final bool enableDeletion; // Added enableDeletion flag

  const SwipeToDeleteItem({
    required this.person,
    required this.onDelete,
    required this.onTap,
    this.enableDeletion = true, // Default to true for backward compatibility
    super.key,
  });

  @override
  State<SwipeToDeleteItem> createState() => _SwipeToDeleteItemState();
}

class _SwipeToDeleteItemState extends State<SwipeToDeleteItem> with SingleTickerProviderStateMixin {
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
          height: 75,
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.person, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)), // Temadan alındı
              Icon(Icons.person, color: Theme.of(context).colorScheme.onPrimary), // Temadan alındı
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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.error, // Temadan alındı
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(Icons.delete, color: Theme.of(context).colorScheme.onError), // Temadan alındı
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
              // Trigger delete if dragExtent exceeds a threshold (e.g., 50 pixels)
              if (dragExtent > 50.0) {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Kişiyi Sil'),
                      content: Text('${widget.person} silinsin mi?'),
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

class PersonSelectionList extends StatefulWidget {
  final void Function(String person) onSelect;
  final bool enableDeletion; // Added enableDeletion flag
  final bool enableAdding; // Added enableAdding flag

  const PersonSelectionList({
    required this.onSelect,
    this.enableDeletion = true, // Default to true
    this.enableAdding = true, // Default to true
    super.key,
  });

  @override
  State<PersonSelectionList> createState() => _PersonSelectionListState();
}

class _PersonSelectionListState extends State<PersonSelectionList> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _showAddPersonDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text('Yeni Kişi Ekle', style: TextStyle(color: Theme.of(context).primaryColor)),
          content: TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(hintText: "Kişi Adı"),
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          actions: [
            TextButton(
              child: const Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
                _textEditingController.clear();
              },
            ),
            TextButton(
              child: const Text('Ekle'),
              onPressed: () {
                final newPerson = _textEditingController.text.trim();
                if (newPerson.isNotEmpty) {
                  setState(() {
                    globals.peopleList.add(newPerson);
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
        borderRadius: BorderRadius.circular(16),
      ), 
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 100), // add bottom padding for button
                itemCount: globals.peopleList.length,
                itemBuilder: (context, index) {
                  final person = globals.peopleList[index];
                  return SwipeToDeleteItem(
                    key: ValueKey(person), // Added unique key
                    person: person,
                    onDelete: () {
                      setState(() {
                        globals.peopleList.removeAt(index);
                      });
                    },
                    onTap: () {
                      widget.onSelect(person);
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
                        _showAddPersonDialog(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2), // Temadan alındı
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: Theme.of(context).colorScheme.onPrimary, // Temadan alındı
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}