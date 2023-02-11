import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';

class InterestButton extends StatefulWidget {
  const InterestButton({
    super.key,
    required this.interest,
  });

  final String interest;

  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  bool _isSelected = false;
  void _onTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final textColor = isDark ? Colors.black : Colors.white;
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: const Duration(
          microseconds: 300,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
          vertical: Sizes.size12,
        ),
        decoration: BoxDecoration(
          color: _isSelected
              ? Theme.of(context).primaryColor
              : Theme.of(context)
                  .buttonTheme
                  .colorScheme!
                  .outline
                  .withOpacity(0.5),
          border: Border.all(
            color: Colors.black.withOpacity(
              0.1,
            ),
          ),
          borderRadius: BorderRadius.circular(
            Sizes.size32,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                0.2,
              ),
              blurRadius: Sizes.size05,
            ),
          ],
        ),
        child: Text(
          widget.interest,
          style: textTheme.bodyLarge!.copyWith(
            color: _isSelected
                ? textColor
                : textColor.withOpacity(
                    0.5,
                  ),
          ),
        ),
      ),
    );
  }
}
