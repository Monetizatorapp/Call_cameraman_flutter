import 'package:flutter/material.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';

class TimeOption extends StatelessWidget {
  final String value;
  final String label;
  final void Function(String)? onChanged;
  final String? groupValue;

  const TimeOption({
    Key? key,
    required this.value,
    required this.label,
    required this.onChanged,
    required this.groupValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          activeColor: AppColors.appPurple,
          value: value,
          groupValue: groupValue,
          onChanged:
              onChanged != null ? (value) => onChanged!(value.toString()) : null,
        ),
        const SizedBox(width: 8,),
        Text(
          label,
          style: AppTextStyles.black14w400,
        ),
      ],
    );
  }
}
