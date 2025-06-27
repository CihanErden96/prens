import 'package:flutter/material.dart';
import 'package:prens/models/question.dart';
import 'package:prens/services/question_service.dart';

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

class QuestionSelectionList extends StatefulWidget {
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
  State<QuestionSelectionList> createState() => _QuestionSelectionListState();
}

class _QuestionSelectionListState extends State<QuestionSelectionList> {
  final TextEditingController _textEditingController = TextEditingController();
  List<Question> _questions = [];
  bool _isLoading = false;

  // --- Placeholder for AppConfig initialization ---
  // You need to replace `AppConfig()` with the correct way to
  // initialize or obtain an AppConfig instance based on your project structure.
  // The previous errors indicated AppConfig() constructor requires parameters.
  // Example (if AppConfig had a fromEnvironment method):
  // final MsalAuthService authService = MsalAuthService(AppConfig.fromEnvironment(Environment.development));
  // Example (if AppConfig is a singleton):
  // final MsalAuthService authService = MsalAuthService(AppConfig.instance);
  // For now, we'll keep the potentially incorrect initialization but highlight it.

  // Instantiate the QuestionService
  late final QuestionService _questionService;

  @override
  void initState() {
    super.initState();
    // Initialize the QuestionService with the auth service
    _questionService = QuestionService();
    _fetchQuestions(); // Fetch questions when the widget initializes
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  // Method to fetch questions from the API using QuestionService
  Future<void> _fetchQuestions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final fetchedQuestions = await _questionService.fetchQuestions();
      setState(() {
        _questions = fetchedQuestions;
        _isLoading = false;
      });
    } catch (e) {
      // Handle errors (e.g., show a SnackBar)
      print('Error fetching questions: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load questions: ${e.toString()}')),
      );
    }
  }

  // Method to add a new question via API using QuestionService
  Future<void> _addQuestion(String questionText) async {
    try {
      // The QuestionService.addQuestion method now handles the API call.
      // After successful addition, refetch the list to show the new question.
      await _questionService.addQuestion(questionText);
      _fetchQuestions(); // Refetch to update the list
    } catch (e) {
      // Handle errors
      print('Error adding question: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add question: ${e.toString()}')),
      );
    }
  }

  // Method to delete a question via API using QuestionService
  Future<void> _deleteQuestion(int questionId) async {
    try {
      // The QuestionService.deleteQuestion method now handles the API call.
      await _questionService.deleteQuestion(questionId);
      // If successful, remove from local list and update UI
      setState(() {
        _questions.removeWhere((q) => q.soruId == questionId);
      });
      print('Question deleted successfully');
    } catch (e) {
      // Handle errors
      print('Error deleting question: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete question: ${e.toString()}')),
      );
      // If deletion failed on backend, you might want to refetch the list
      // _fetchQuestions();
    }
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
                  _addQuestion(
                    newQuestionText,
                  ); // Call add method which uses QuestionService
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
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    ) // Show loading indicator
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 100),
                      itemCount: _questions.length, // Use fetched questions
                      itemBuilder: (context, index) {
                        final question = _questions[index];
                        return SwipeToDeleteItem(
                          key: ValueKey(
                            question.soruId,
                          ), // Use unique ID as key
                          question: question, // Pass the Question object
                          onDelete:
                              _deleteQuestion, // Pass the delete method which uses QuestionService
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
