import 'package:flutter/material.dart';
import '../../../core/widgets/local_image.dart';
import '../../../core/widgets/text.dart';

class FilterTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconName;
  final VoidCallback onTap;

  const FilterTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.iconName = "right-arrow",
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 2),
                    CustomText(
                      text: subtitle.isEmpty ? "Select $title" : subtitle,
                      fontSize: 14,
                      color: subtitle.isEmpty
                          ? Theme.of(context).hintColor
                          : null,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              LocalImage(
                img: iconName,
                type: "svg",
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}