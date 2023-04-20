import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodly/components/menu_card.dart';
import 'package:foodly/components/restaruant_categories.dart';
import 'package:foodly/components/restaurant_info.dart';
import 'package:foodly/models/menu.dart';

import 'components/restaurant_appbar.dart';


class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  final scrollController = ScrollController();

  int selectedCategoryIndex = 0;

  double restaurantInfoHeight = 200 //AppBar expanded height
  + 170 //Restaurant info height
  - kToolbarHeight;

  @override
  void initState() {
    createBreakpoints();
    scrollController.addListener(() {
      updateCategoryIndexOnScroll(scrollController.offset);
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollToCategory(int index) {
    if(selectedCategoryIndex != index) {
      int totalItems = 0;
      for(var i = 0; i < index; i++) {
        totalItems += demoCategoryMenus[i].items.length;
      }
      scrollController.animateTo(
        //116 = 100 menu item height + 16 bottom padding of each time
        //Alomost made it but not perfect
        //50 = 18 title font size + 32 (16 vertical padding on title)
          restaurantInfoHeight + (116 * totalItems) + (50 * index),
          duration: Duration(milliseconds: 500),
          curve: Curves.ease
      );
      setState(() {
        selectedCategoryIndex = index;
      });
    }
  }

  //scroll to selected category
  List<double> breakpoints = [];
  void createBreakpoints() {
    double firstBreakpoint = restaurantInfoHeight + 50 + (116 * demoCategoryMenus[0].items.length);

    breakpoints.add(firstBreakpoint);
    for(var i = 0; i < demoCategoryMenus.length; i++) {
      double breakpoint = breakpoints.last + 50 + (116 * demoCategoryMenus[i].items.length);
      breakpoints.add(breakpoint);
    }
  }

  //Now we know the break points
  void updateCategoryIndexOnScroll(double offset) {
    for(var i =0; i < demoCategoryMenus.length; i++) {
      if(i == 0) {
        if((offset < breakpoints.first) & (selectedCategoryIndex!= 0)) {
          setState(() {
            selectedCategoryIndex = 0;
          });
        }
      }
      else if((breakpoints[i - 1] <= offset) & (offset < breakpoints[i])) {
        if(selectedCategoryIndex != i) {
          setState(() {
            selectedCategoryIndex = i;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          RestaurantAppBar(),
          SliverToBoxAdapter(
            child: RestaurantInfo(),
          ),
          SliverPersistentHeader(
            delegate: RestaurantCategories(
              onChanged: scrollToCategory,
              selectedIndex: selectedCategoryIndex,
            ),
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, categoryIndex) {
                  List<Menu> items = demoCategoryMenus[categoryIndex].items;
                  return MenuCategoryItem(
                    title: demoCategoryMenus[categoryIndex].category,
                    items: List.generate(
                        items.length,
                            (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: MenuCard(
                            title: items[index].title,
                            image: items[index].image,
                            price: items[index].price,
                          ),
                        )
                    ),
                  );
                },
                childCount: demoCategoryMenus.length,

              ),
            ),
          )
        ],
      ),
    );
  }
}

