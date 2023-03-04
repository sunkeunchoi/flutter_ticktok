// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';

class NavTap extends StatelessWidget {
  final String text;
  final bool isSelected;
  final IconData icon;
  final IconData selectedIcon;
  final VoidCallback onTap;
  final int selectedIndex;
  final AppColors appColor;
  const NavTap({
    super.key,
    required this.text,
    required this.isSelected,
    required this.icon,
    required this.selectedIcon,
    required this.onTap,
    required this.selectedIndex,
    this.appColor = AppColors.inverseSurface,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = appColor.getColors(context);
    final colors = selectedIndex == 0 ? scheme : scheme.invert;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: colors.background,
          child: AnimatedOpacity(
            opacity: isSelected ? 1 : 0.6,
            duration: const Duration(
              milliseconds: 300,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  isSelected ? selectedIcon : icon,
                  color: colors.main,
                ),
                Gaps.v10,
                Text(
                  text,
                  style: TextStyle(
                    color: colors.main,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
