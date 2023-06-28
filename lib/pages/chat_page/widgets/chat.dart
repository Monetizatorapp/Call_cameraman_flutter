import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sirenhead_test/pages/chat_page/widgets/list_of_questions.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';

class Chat extends StatefulWidget {
  const Chat({
    super.key,
  });

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final Map<String, String> _chatData = {
    tr("Question1"): tr("question1"),
    tr("Question2"): tr("question2"),
    tr("Question3"): tr("question3"),
    tr("Question4"): tr("question4"),
    tr("Question5"):
        tr("question5"),
    tr("Question6"): tr("question6"),
    tr("Question7"): tr("question7"),
    tr("Question8"): tr("question8"),
    tr("Question9"): tr("question9"),
    tr("Question10"): tr("question10"),
  };
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final ScrollController _controller = ScrollController();
  final List<String> _items = [];

  void _addItem(String item) {
    if (_items.isEmpty) {
      _items.insert(0, item);
      _listKey.currentState!
          .insertItem(0, duration: const Duration(milliseconds: 300));
    } else {
      _items.add(item);
      _listKey.currentState!.insertItem(_items.length - 1,
          duration: const Duration(milliseconds: 300));
    }
    Timer(const Duration(milliseconds: 500), () {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _answer(String question) {
    _addItem(question);
    Future.delayed(const Duration(milliseconds: 700), () {
      _addItem(_chatData[question] ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(
          child: AnimatedList(
            controller: _controller,
            key: _listKey,
            initialItemCount: 0,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            itemBuilder:
                (BuildContext context, int index, Animation<double> animation) {
              return ScaleTransition(
                key: UniqueKey(),
                scale: animation,
                child: index.isOdd
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            constraints: BoxConstraints(maxWidth: width / 2),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white),
                            child: Text(
                              _items[index],
                              style: AppTextStyles.chat14w400Black,
                            ),
                          ),
                        ),
                      )
                    : Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            constraints: BoxConstraints(maxWidth: width / 2),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.appPurple),
                            child: Text(
                              _items[index],
                              // textAlign: TextAlign.right,
                              style: AppTextStyles.chat14w400White,
                            ),
                          ),
                        ),
                      ),
              );
            },
          ),
        ),
        SizedBox(
          height: 60,
          child: ListOfQuestions(
            listOfQuestions: _chatData.keys,
            action: _answer,
          ),
        )
      ],
    );
  }
}
