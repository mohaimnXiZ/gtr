import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gtr/core/widgets/button.dart';
import 'package:gtr/core/widgets/local_image.dart';
import 'package:gtr/core/widgets/text.dart';
import 'package:gtr/core/widgets/text_fields.dart';
import 'package:gtr/features/search/component/filter_tile.dart';
import 'package:gtr/features/search/component/search_product_card.dart';
import 'package:iconsax/iconsax.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Padding(
          padding: EdgeInsets.only(top: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: CustomField(
                  controller: _searchController,
                  prefixWidget: SizedBox(
                    height: 20,
                    width: 20,
                    child: Center(
                      child: LocalImage(img: "phone", type: "svg", fit: BoxFit.contain),
                    ),
                  ),
                  hintText: "search",
                ),
              ),
              SizedBox(width: 18),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                onTap: () {
                  _openSheet(
                    context,
                    SafeArea(
                      child: FractionallySizedBox(
                        heightFactor: 0.9,
                        child: Padding(
                          padding: EdgeInsetsGeometry.symmetric(horizontal: 14),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 8),
                              Container(
                                width: 44,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: Color(0xFFDFDFDF),
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                ),
                              ),
                              SizedBox(height: 18),
                              SizedBox(
                                height: 40, // Set a height for your header row
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // 1. The Title - Mathematically centered
                                    CustomText(text: "Filter", fontSize: 18, fontWeight: FontWeight.bold),
                      
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(width: 48),
                                        GestureDetector(
                                          onTap: () => Navigator.pop(context),
                                          child: CustomText(
                                            text: "cancel",
                                            fontSize: 14,
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(color: Theme.of(context).dividerColor),
                              SizedBox(height: 16),
                              FilterTile(
                                title: "Brands",
                                subtitle: "Rolls Royce, Ferrari, Lamborghini, Mercedes, Mercedes",
                                onTap: () {
                                  _openSheet(context, _buildBrands());
                                },
                              ),
                              FilterTile(
                                title: "Models",
                                subtitle: "Huracan EVO",
                                onTap: () {
                                  _openSheet(context, _buildModels());
                                },
                              ),
                              FilterTile(
                                title: "Model Year",
                                subtitle: "2016, 2026",
                                onTap: () {
                                  _openSheet(context, _buildYear());

                                },
                              ),
                              FilterTile(
                                title: "Vehicle Type",
                                subtitle: "Economic",
                                onTap: () {
                                  _openSheet(context, _buildType());
                                },
                              ),
                              FilterTile(
                                title: "Car Colors",
                                subtitle: "Black, Silver",
                                onTap: () {
                                  _openSheet(context, _buildColors());
                                },
                              ),
                              SizedBox(height: 8),
                              Align(alignment:Alignment.centerLeft,child: CustomText(text: "Price Range", fontSize: 18, fontWeight: FontWeight.bold,)),
                              Spacer(),
                              Row(mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:[
                                Expanded(child: CustomButton(title: "reset",textColor: Theme.of(context).colorScheme.onSurface,color: Theme.of(context).colorScheme.onPrimaryContainer,onTap: (){})),
                                SizedBox(width: 16,),
                                Expanded(child: CustomButton(title: "Apply Filter",onTap: (){}))
                              ],),
                              SizedBox(height: 6),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    border: Border.all(width: 1, color: Theme.of(context).colorScheme.outline),
                  ),
                  child: LocalImage(img: "filter", type: "svg"),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 18),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(10, (index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {},
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: LocalImage(img: "car-logo", type: "svg", size: 36),
                              ),
                              const SizedBox(height: 8),
                              CustomText(text: "Mercedes", fontSize: 12),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            SearchProductCard(
              carName: "Rolls Royce Ghost Series 2",
              carImage: "car6",
              price: "2300",
              hp: "550",
              transmission: "automatic",
              seatCount: "4",
              onBookTap: () {},
            ),
            SearchProductCard(
              carName: "Rolls Royce Ghost Series 2",
              carImage: "car6",
              price: "2300",
              hp: "550",
              transmission: "automatic",
              seatCount: "4",
              onBookTap: () {},
            ),
            SearchProductCard(
              carName: "Rolls Royce Ghost Series 2",
              carImage: "car6",
              price: "2300",
              hp: "550",
              transmission: "automatic",
              seatCount: "4",
              onBookTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

Future<String?> _openSheet(BuildContext context, Widget content) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (context) => content,
  );
}

Widget _buildBrands(){
  return SizedBox.shrink();
}

Widget _buildModels(){
  return SizedBox.shrink();
}

Widget _buildYear(){
  return SizedBox.shrink();
}

Widget _buildType(){
  return SizedBox.shrink();
}

Widget _buildColors(){
  return SizedBox.shrink();
}


