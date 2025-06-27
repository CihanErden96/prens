import 'package:flutter/material.dart';
import 'package:prens/constants/global_variables.dart' as globals;

class SwipeToDeleteItem extends StatefulWidget {
  final String question;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final bool enableDeletion; // Added enableDeletion flag

  const SwipeToDeleteItem({
    required this.question,
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
          constraints: const BoxConstraints(minHeight: 50),
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  constraints: const BoxConstraints(minWidth: 100),
                  child: Text(
                    widget.question,
                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary), // Temadan alındı
                  ),
                ),
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
                      title: Text('Kişiyi Sil', style: Theme.of(context).textTheme.headlineSmall), // Temadan alındı
                      content: Text('${widget.question} silinsin mi?', style: Theme.of(context).textTheme.bodyMedium), // Temadan alındı
                      actions: [
                        TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text('Hayır', style: Theme.of(context).textTheme.labelLarge)), // Temadan alındı
                        TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text('Evet', style: Theme.of(context).textTheme.labelLarge)), // Temadan alındı
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

class QuestionSelectionList extends StatefulWidget {
  final void Function(String question) onSelect;
  final bool enableDeletion; // Added enableDeletion flag
  final bool enableAdding; // Added enableAdding flag

  const QuestionSelectionList({
    required this.onSelect,
    this.enableDeletion = true, // Default to true
    this.enableAdding = true, // Default to true
    super.key,
  });

  @override
  State<QuestionSelectionList> createState() => _QuestionSelectionListState();
}

class _QuestionSelectionListState extends State<QuestionSelectionList> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _showAddquestionDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text('Yeni Kişi Ekle', style: Theme.of(context).textTheme.headlineSmall), // Temadan alındı
          content: TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(hintText: "Kişi Adı"),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface), // Temadan alındı
          ),
          actions: [
            TextButton(
              child: Text('İptal', style: Theme.of(context).textTheme.labelLarge), // Temadan alındı
              onPressed: () {
                Navigator.of(context).pop();
                _textEditingController.clear();
              },
            ),
            TextButton(
              child: Text('Ekle', style: Theme.of(context).textTheme.labelLarge), // Temadan alındı
              onPressed: () {
                final newquestion = _textEditingController.text.trim();
                if (newquestion.isNotEmpty) {
                  setState(() {
                    globals.peopleList.add(newquestion);
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
                itemCount: globals.questionList.length,
                itemBuilder: (context, index) {
                  final question = globals.questionList[index];
                  return SwipeToDeleteItem(
                    key: ValueKey(question), // Added unique key
                    question: question,
                    onDelete: () {
                      setState(() {
                        globals.peopleList.removeAt(index);
                      });
                    },
                    onTap: () {
                      widget.onSelect(question);
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
                        _showAddquestionDialog(context);
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