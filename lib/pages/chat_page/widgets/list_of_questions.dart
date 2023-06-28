import 'package:flutter/material.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';

class ListOfQuestions extends StatefulWidget {
  const ListOfQuestions({
    super.key,
    required this.listOfQuestions,
    required this.action,
  });

  final ValueChanged<String> action;
  final Iterable<String> listOfQuestions;

  @override
  State<ListOfQuestions> createState() => _ListOfQuestionsState();
}

class _ListOfQuestionsState extends State<ListOfQuestions> {
  late final List<String> _questions;
  final GlobalKey<AnimatedListState> _listKey =
  GlobalKey(); // Add a GlobalKey for AnimatedList
  @override
  void initState() {
    super.initState();
    _questions = List.from(widget.listOfQuestions);
  }

  void _removeItem(int index) {
    final question = _questions.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
          (context, animation) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        );
        return SizeTransition(
          sizeFactor: curved,
          axis: Axis.horizontal,
          child: buildQuestionItem(index, text: question, remove: true),
        );
      },
      duration: const Duration(milliseconds: 500),
    );
  }

  Widget buildQuestionItem(int index, {String? text, bool remove = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
        onTap: !remove
            ? () {
          widget.action(_questions[index]);
          _removeItem(index);
        }
            : null,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.appPurple,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              text ?? _questions[index],
              style: AppTextStyles.chat14w400White,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index, animation) {
        // Build the question item with fade in animation
        return FadeTransition(
          opacity: animation,
          child: buildQuestionItem(index),
        );
      },
      initialItemCount: _questions.length,
    );
  }
}

