
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';
import 'package:sirenhead_test/utils/enums/call_app.dart';

class SelectTypeSocial extends StatefulWidget {
  final String title;
  final String icon;
  final ValueChanged<CallApp> onTap;
  final CallApp selectedType;

  const SelectTypeSocial({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.selectedType,
  }) : super(key: key);

  @override
  State<SelectTypeSocial> createState() => _SelectTypeSocialState();
}

class _SelectTypeSocialState extends State<SelectTypeSocial> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.selectedType != _getType()) {
          widget.onTap(_getType());
        }
      },
      child: Container(
        width: 169,
        height: 43,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: widget.selectedType == _getType()
              ? AppColors.appPurple
              : Colors.transparent,
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.title,
              style: widget.selectedType == _getType()
                  ? AppTextStyles.incoming14w600
                  : AppTextStyles.black14w600,
            ),
            SvgPicture.asset(widget.icon),
          ],
        ),
      ),
    );
  }

  CallApp _getType() {
    if (widget.title == 'WhatsApp') {
      return CallApp.whatsApp;
    } else if (widget.title == 'Facebook') {
      return CallApp.messenger;
    } else {
      return CallApp.telegram;
    }
  }
}
