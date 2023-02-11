import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.disabled,
    required this.text,
    required this.onTap,
  });

  final bool disabled;
  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textStyle = Theme.of(context).textTheme;
    final textColor = isDark ? Colors.black : Colors.white;
    final disabledColor = isDark ? Colors.grey.shade700 : Colors.grey.shade500;
    return GestureDetector(
      onTap: disabled ? () {} : onTap,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: Sizes.size14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Sizes.size05,
            ),
            color: !disabled ? Theme.of(context).primaryColor : disabledColor,
          ),
          child: AnimatedDefaultTextStyle(
            style: textStyle.titleLarge!.copyWith(
              color: !disabled ? textColor : disabledColor,
              fontWeight: FontWeight.w600,
            ),
            duration: const Duration(microseconds: 300),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: textStyle.titleLarge!.copyWith(
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
