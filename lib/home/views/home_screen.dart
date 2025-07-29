import 'package:flutter/material.dart';
import 'package:stock_exchange_app/home/widgets/indices_card.dart';
import 'package:stock_exchange_app/home/widgets/top_navigation_option.dart';

import '../dummy data/stock_indices.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => const HomeScreen());
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedIndex = 0;
  final List<String> options = ['Explore', 'Holdings', 'Positions', 'Orders'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/images/stock.png'),
                backgroundColor: Colors.transparent,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Stocks',
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, size: 28),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.local_offer_sharp),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () {},
              child: const CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/images/vamshi.jpg'),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIndices(),
            const SizedBox(height: 40),
            _buildTopNavigation(context,options),
          ],
        ),
      ),
    );
  }

  Widget _buildIndices() {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stockIndices.length,
        itemBuilder: (context, index) {
          final stock = stockIndices[index];
          return SizedBox(width: 225, child: IndicesCard(stock: stock));
        },
      ),
    );
  }

  Widget _buildTopNavigation(BuildContext context, List options) {
    return Row(
      children: List.generate(options.length, (index){
        return Expanded(
            child: TopNavigationOption(
                option: options[index],
              isSelected: selectedIndex == index,
              onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
              },
            )
        );
      })
    );
  }
}
