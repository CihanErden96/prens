import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:prens/models/question.dart';
// Remove unused import: import 'package:prens/services/question_service.dart';
import 'package:prens/providers/question_provider.dart'; // Import the question provider

class SwipeToDeleteItem extends StatefulWidget {
  // Changed type to Question
  final Question question;
  // Changed onDelete to pass question ID
  final void Function(int questionId) onDelete;
  // Changed onTap to pass Question object
  final void Function(Question question) onTap;
  final bool enableDeletion;

  const SwipeToDeleteItem({
    required this.question,
    required this.onDelete,
    required this.onTap,
    this.enableDeletion = true,
    super.key,
  });

  @override
  State<SwipeToDeleteItem> createState() => _SwipeToDeleteItemState();
}

class _SwipeToDeleteItemState extends State<SwipeToDeleteItem>
    with SingleTickerProviderStateMixin {
  double dragExtent = 0.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void resetPosition() {
    _controller.reverse();
    setState(() {
      dragExtent = 0.0;
    });
  }

  void animateOffscreen() {
    _controller.forward().then((_) {
      // Pass the question ID to onDelete
      widget.onDelete(widget.question.soruId);
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
        onTap: () => widget.onTap(widget.question), // Pass the question object
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
                    widget.question.soruMetni, // Use soruMetni
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
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
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                dragExtent += details.delta.dx;
                dragExtent = dragExtent.clamp(0.0, 75.0);
              });
            },
            onHorizontalDragEnd: (details) async {
              if (dragExtent > 50.0) {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Soruyu Sil',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      content: Text(
                        '${widget.question.soruMetni} silinsin mi?',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(
                            'Hayır',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text(
                            'Evet',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
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
            child: listItem,
          ),
        ],
      );
    } else {
      return listItem;
    }
  }
}

class QuestionSelectionList extends ConsumerStatefulWidget { // Change to ConsumerStatefulWidget
  // Changed onSelect to pass Question object
  final void Function(Question question) onSelect;
  final bool enableDeletion;
  final bool enableAdding;

  const QuestionSelectionList({
    required this.onSelect,
    this.enableDeletion = true,
    this.enableAdding = true,
    super.key,
  });

  @override
  ConsumerState<QuestionSelectionList> createState() => _QuestionSelectionListState();
}

class _QuestionSelectionListState extends ConsumerState<QuestionSelectionList> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load questions when the widget initializes using the Riverpod provider
    // We use ref.read to access the notifier's methods from initState
    // Use addPostFrameCallback to ensure context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(questionListProvider.notifier).loadQuestions();
    });
  }

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
          title: Text(
            'Yeni Soru Ekle',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          content: TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(hintText: "Soru Metni"),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'İptal',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _textEditingController.clear();
              },
            ),
            TextButton(
              child: Text(
                'Ekle',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: () {
                final newQuestionText = _textEditingController.text.trim();
                if (newQuestionText.isNotEmpty) {
                  // Call add method on the Riverpod notifier
                  ref.read(questionListProvider.notifier).addQuestion(newQuestionText);
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
    // Watch the question list from the provider
    final questions = ref.watch(questionListProvider);

    // You might want to handle loading and error states here based on your QuestionNotifier implementation
    // For example, if your notifier exposes a loading state:
    // final questionState = ref.watch(questionListProvider);
    // if (questionState.isLoading) { return Center(child: CircularProgressIndicator()); }
    // if (questionState.hasError) { return Center(child: Text('Error: ${questionState.error}')); }
    // final questions = questionState.value!;

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
              // Check if questions are loaded (assuming non-empty list means loaded)
              child: questions.isEmpty // This might need refinement if empty list is valid state
                  ? Center(
                      child: CircularProgressIndicator(),
                    ) // Show loading indicator or empty state
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 100),
                      itemCount: questions.length, // Use questions from provider
                      itemBuilder: (context, index) {
                        final question = questions[index];
                        return SwipeToDeleteItem(
                          key: ValueKey(
                            question.soruId,
                          ), // Use unique ID as key
                          question: question, // Pass the Question object
                          onDelete: (questionId) {
                            // Call delete method on the Riverpod notifier
                            ref.read(questionListProvider.notifier).deleteQuestion(questionId);
                          }, // Pass the delete method
                          onTap: (selectedQuestion) {
                            // Receive the selected Question object
                            widget.onSelect(
                              selectedQuestion,
                            ); // Pass it to the parent
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
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.2),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: Theme.of(context).colorScheme.onPrimary,
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