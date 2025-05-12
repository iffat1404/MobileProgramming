import 'package:flutter/material.dart';
import 'package:lab_7_food_delivery/models/restaurant.dart';
import 'package:lab_7_food_delivery/screens/restaurant_screen.dart';
import 'package:lab_7_food_delivery/theme/app_theme.dart';
import 'package:lab_7_food_delivery/widgets/category_item.dart';
import 'package:lab_7_food_delivery/widgets/restaurant_card.dart';
import 'package:lab_7_food_delivery/widgets/search_bar.dart';
import 'package:lab_7_food_delivery/data/dummy_data.dart';
import 'package:lab_7_food_delivery/widgets/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ["All", "Nearby", "Popular", "New", "Trending"];
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _navigateToRestaurant(Restaurant restaurant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurantScreen(restaurant: restaurant),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      appBar: AppBar(
        title: const Text("FoodExpress"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to cart
            },
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hungry?",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Order food from the best restaurants",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    const CustomSearchBar(),
                    const SizedBox(height: 24),
                    Text(
                      "Categories",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          CategoryItem(
                            icon: Icons.lunch_dining,
                            title: "Burgers",
                            color: Color(0xFFE1BEE7),
                          ),
                          CategoryItem(
                            icon: Icons.local_pizza,
                            title: "Pizza",
                            color: Color(0xFFCE93D8),
                          ),
                          CategoryItem(
                            icon: Icons.restaurant,
                            title: "Dinner",
                            color: Color(0xFFBA68C8),
                          ),
                          CategoryItem(
                            icon: Icons.coffee,
                            title: "Coffee",
                            color: Color(0xFF9C27B0),
                          ),
                          CategoryItem(
                            icon: Icons.icecream,
                            title: "Desserts",
                            color: Color(0xFF7B1FA2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: AppTheme.accentColor,
                  unselectedLabelColor: AppTheme.lightTextColor,
                  indicatorColor: AppTheme.accentColor,
                  tabs: _tabs.map((String tab) => Tab(text: tab)).toList(),
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: _tabs.map((String tab) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: dummyRestaurants.length,
              itemBuilder: (context, index) {
                return RestaurantCard(
                  restaurant: dummyRestaurants[index],
                  onTap: () => _navigateToRestaurant(dummyRestaurants[index]),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppTheme.primaryColor,
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
