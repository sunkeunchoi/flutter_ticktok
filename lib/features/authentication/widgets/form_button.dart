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
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
            color: !disabled
                ? Theme.of(context).primaryColor
                : isDark
                    ? Colors.grey.shade800
                    : Colors.grey.shade400,
          ),
          child: AnimatedDefaultTextStyle(
            style: TextStyle(
              color: !disabled
                  ? isDark
                      ? Colors.black
                      : Colors.white
                  : isDark
                      ? Colors.grey.shade700
                      : Colors.grey.shade500,
              fontWeight: FontWeight.w600,
            ),
            duration: const Duration(microseconds: 300),
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
