import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/icon.dart';
import '../../../core/widgets/local_image.dart';
import '../../../core/widgets/text.dart';

class ProductCard extends StatelessWidget {
  final String carName;
  final String carImage;
  final String carLogo;
  final String dailyPrice;
  final String monthlyPrice;
  final String? oldPrice;
  final List<String> tags;
  final bool isFirstItem;
  final VoidCallback onDetailsTap;
  final VoidCallback onPhoneTap;
  final VoidCallback onWhatsappTap;

  const ProductCard({
    super.key,
    required this.carName,
    required this.carImage,
    required this.carLogo,
    required this.dailyPrice,
    required this.monthlyPrice,
    this.oldPrice,
    required this.tags,
    this.isFirstItem = false,
    required this.onDetailsTap,
    required this.onPhoneTap,
    required this.onWhatsappTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isFirstItem
            ? const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )
            : null,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header Image & Logo ---
            Stack(
              children: [
                LocalImage(
                  img: carImage,
                  type: "png",
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  alternativeBorderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: LocalImage(img: carLogo, type: "svg", size: 24),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Title & Favorite ---
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          text: carName,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: CustomIcon(icon: Iconsax.heart),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // --- Tags ---
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: tags.map((tag) => _buildTag(tag)).toList(),
                  ),
                  const SizedBox(height: 12),

                  // --- Pricing ---
                  if (oldPrice != null)
                    CustomText(
                      text: oldPrice!,
                      decoration: TextDecoration.lineThrough,
                      color: Theme.of(context).hintColor,
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildPriceText("AED $dailyPrice/Day", context),
                      _buildPriceText("AED $monthlyPrice/Mo", context, isEnd: true),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // --- Features Row ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (index) => _buildFeatureIcon(Iconsax.bag, "2 Bags")),
                  ),
                  const SizedBox(height: 16),

                  // --- Action Buttons ---
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: CustomButton(
                          onTap: onDetailsTap,
                          title: "Car Details",
                          verticalPadding: 10,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildIconButton("phone", const Color(0xFF777777), onPhoneTap),
                      const SizedBox(width: 8),
                      _buildIconButton("whatsapp", const Color(0xFF25D366), onWhatsappTap),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Builders to keep build() clean ---

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: const Color(0xFF3D923A).withAlpha(12),
      ),
      child: CustomText(text: text, fontSize: 12),
    );
  }

  Widget _buildPriceText(String text, BuildContext context, {bool isEnd = false}) {
    return Expanded(
      child: CustomText(
        text: text,
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.w800,
        textAlign: isEnd ? TextAlign.end : TextAlign.start,
        fontSize: 16,
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Flexible(
      child: Column(
        children: [
          CustomIcon(icon: icon),
          const SizedBox(height: 4),
          CustomText(text: label, fontSize: 11),
        ],
      ),
    );
  }

  Widget _buildIconButton(String icon, Color color, VoidCallback tap) {
    return Flexible(
      flex: 1,
      child: CustomButton(
        onTap: tap,
        color: color,
        borderRadius: BorderRadius.circular(16),
        verticalPadding: 10,
        child: LocalImage(img: icon, type: "svg", size: 24),
      ),
    );
  }
}