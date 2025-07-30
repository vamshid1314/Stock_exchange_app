import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stock_exchange_app/home/dummy%20data/stocks_data.dart';
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _buildIndices(),
                const SizedBox(height: 30),
                _buildTopNavigation(context, options),
                const SizedBox(height: 15),
                if(selectedIndex == 0)
                  _buildStocksGrid()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIndices() {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stockIndices.length,
        itemBuilder: (context, index) {
          final stock = stockIndices[index];
          return  IndicesCard(stock: stock);
        },
      ),
    );
  }

  Widget _buildTopNavigation(BuildContext context, List options) {
    return Row(
      children: List.generate(options.length, (index) {
        return Expanded(
          child: TopNavigationOption(
            option: options[index],
            isSelected: selectedIndex == index,
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        );
      }),
    );
  }

  Widget _buildStocksGrid(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Most bought on Trademint ',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: stocksData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final stock = stocksData[index];
            bool changeVal = stock['changeValue'] >= 0;
            return Card(
              elevation: 2,
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: stock['imageUrl'],
                        height: 35,
                        width: 35,
                        placeholder: (context, url) => const SizedBox(
                          height: 35,
                          width: 35,
                          child: Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        errorWidget: (context, url, error) => const SizedBox(
                          height: 35,
                          width: 35,
                          child: Icon(Icons.broken_image, color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      stock['name'],
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Text(
                      '₹${stock['price']}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Row(
                      children: [
                        if(changeVal)
                          const Text(
                            '+',
                            style:TextStyle(
                                fontSize: 13,
                                color: Colors.green
                            ),
                          ),
                        Text(
                          '${stock['changeValue']}(${stock['changePercent']}%)',
                          style: TextStyle(
                              fontSize: 14,
                              color: changeVal ? Colors.green : Colors.red
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 2000),
        const Text('Products and tools'),
        const Row(
          children: [
            Icon(Icons.book_online_outlined)
          ],
        )
      ],
    );
  }
}
