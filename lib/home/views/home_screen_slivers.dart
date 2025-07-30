import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stock_exchange_app/home/dummy%20data/top_movers.dart';

import '../dummy data/stock_indices.dart';
import '../dummy data/stocks_data.dart';
import '../widgets/indices_card.dart';
import '../widgets/top_navigation_option.dart';

class HomeScreenSilvers extends StatefulWidget {
  const HomeScreenSilvers({super.key});

  @override
  State<HomeScreenSilvers> createState() => _HomeScreenSilversState();
}

class _HomeScreenSilversState extends State<HomeScreenSilvers> {
  int selectedIndex = 0;
  final List<String> options = ['Explore', 'Holdings', 'Positions', 'Orders'];

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: false,
            toolbarHeight: screenHeight * 0.075,
            flexibleSpace: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage('assets/images/stock.png'),
                      backgroundColor: Colors.transparent,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Stocks',
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search, size: 28),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.local_offer_sharp),
                    ),
                    const CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage('assets/images/vamshi.jpg'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [const SizedBox(height: 10), _buildIndices()],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _NavigationBarDelegate(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      child: _buildTopNavigation(context, options),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (selectedIndex == 0) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, bottom: 20),
                child: Text(
                  'Most bought on Trademint ',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            _buildStocksSliverGrid(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 40, left: 10, bottom: 25),
                child: Text(
                  'Products and tools',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.book_online, size: 40),
                    Icon(Icons.book_online, size: 40),
                    Icon(Icons.book_online, size: 40),
                    Icon(Icons.book_online, size: 40),
                    Icon(Icons.book_online, size: 40),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 40, left: 10,bottom: 20),
                child: Text(
                  'Top movers today',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                final stock = topMovers[index];
                bool changeVal = stock['changeValue'] >= 0;
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
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
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const SizedBox(
                                  height: 35,
                                  width: 35,
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Colors.red,
                                  ),
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
                            if (changeVal)
                              const Text(
                                '+',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.green,
                                ),
                              ),
                            Text(
                              '${stock['changeValue']}(${stock['changePercent']}%)',
                              style: TextStyle(
                                fontSize: 14,
                                color: changeVal ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: stocksData.length),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
            ),
          ],
          const SliverFillRemaining(),
        ],
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
          return IndicesCard(stock: stock);
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

  SliverGrid _buildStocksSliverGrid() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
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
                    if (changeVal)
                      const Text(
                        '+',
                        style: TextStyle(fontSize: 13, color: Colors.green),
                      ),
                    Text(
                      '${stock['changeValue']}(${stock['changePercent']}%)',
                      style: TextStyle(
                        fontSize: 14,
                        color: changeVal ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }, childCount: stocksData.length),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }
}

class _NavigationBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _NavigationBarDelegate({required this.child});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  double get maxExtent => 90;

  @override
  double get minExtent => 90;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
