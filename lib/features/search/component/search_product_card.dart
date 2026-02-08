import 'package:flutter/material.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/local_image.dart';
import '../../../core/widgets/text.dart';

class SearchProductCard extends StatefulWidget {
  final String carName;
  final String carImage;
  final String price;
  final String hp;         // Pass just the number, e.g., "577"
  final String transmission;
  final String seatCount;  // Pass just the number, e.g., "4"
  final bool initialFavorite;
  final Function(bool)? onFavoriteChanged;
  final VoidCallback onBookTap;

  const SearchProductCard({
    super.key,
    required this.carName,
    required this.carImage,
    required this.price,
    required this.hp,
    required this.transmission,
    required this.seatCount,
    this.initialFavorite = false,
    this.onFavoriteChanged,
    required this.onBookTap,
  });

  @override
  State<SearchProductCard> createState() => _SearchProductCardState();
}

class _SearchProductCardState extends State<SearchProductCard> with SingleTickerProviderStateMixin {
  late bool _isFavorite;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.initialFavorite;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() => _isFavorite = !_isFavorite);
    _controller.forward().then((_) => _controller.reverse());
    if (widget.onFavoriteChanged != null) {
      widget.onFavoriteChanged!(_isFavorite);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LocalImage(img: widget.carImage, type: "png"),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomText(
                      text: widget.carName,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: _toggleFavorite,
                    child: ScaleTransition(
                      scale: Tween(begin: 1.0, end: 1.3).animate(
                        CurvedAnimation(parent: _controller, curve: Curves.easeOut),
                      ),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: _isFavorite ? Colors.red : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: "\$${widget.price}/day",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // --- Wrapping Tags with Appended Units ---
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  alignment: WrapAlignment.start,
                  children: [
                    _buildFixedTag("engine", "${widget.hp} hp"),
                    _buildFixedTag("gear", widget.transmission),
                    _buildFixedTag("seat", "${widget.seatCount} seats"),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              CustomButton(
                title: "Book Now",
                onTap: widget.onBookTap,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFixedTag(String iconName, String value) {
    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            LocalImage(img: iconName, type: "svg", size: 16, fit: BoxFit.contain),
            const SizedBox(width: 6),
            CustomText(text: value, fontSize: 12),
          ],
        ),
      ),
    );
  }
}