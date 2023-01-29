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
            color: disabled
                ? Colors.grey.shade400
                : Theme.of(context).primaryColor,
          ),
          child: AnimatedDefaultTextStyle(
            style: TextStyle(
              color: disabled ? Colors.grey.shade500 : Colors.white,
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
