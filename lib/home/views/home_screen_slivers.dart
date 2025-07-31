import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stock_exchange_app/home/widgets/grid_card_builder.dart';
import '../dummy data/stock_indices.dart';
import '../dummy data/stocks_data.dart';
import '../dummy data/stocks_in_news.dart';
import '../dummy data/top_gainers.dart';
import '../dummy data/top_losers.dart';
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
  String selectedChip = 'Gainers';

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
            _buildStocksSliverGrid(whichStock: 'Most bought'),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 40, left: 10, bottom: 25),
                child: Text(
                  'Products and tools',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildToolIcon('IPO', 'assets/images/IPO.png', () {}),
                    _buildToolIcon('Bonds', 'assets/images/bond.png', () {}),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 40, left: 10, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Top movers today',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 10),
                    _buildChips(),
                  ],
                ),
              ),
            ),
            _buildTopMoversGrid(selectedChip),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 40, left: 10, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stocks in news',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            _buildStocksSliverGrid(whichStock: 'Stocks in news'),
            const SliverToBoxAdapter(child: SizedBox(height: 70)),
          ],
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

  Row _buildChips() {
    return Row(
      children: [
        ActionChip(
          label: const Text('Gainers', style: TextStyle(fontSize: 14)),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          // Less padding
          visualDensity: VisualDensity.compact,
          onPressed: () {
            setState(() {
              selectedChip = 'Gainers';
            });
          },
          backgroundColor: selectedChip == 'Gainers' ? Colors.grey[300] : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
            side: BorderSide(
              color: selectedChip == 'Gainers' ? Colors.grey : Colors.black,
              width: selectedChip == 'Gainers' ? 2 : 1,
            ),
          ),
        ),
        const SizedBox(width: 10),
        ActionChip(
          label: const Text('Losers', style: TextStyle(fontSize: 14)),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          // Less padding
          visualDensity: VisualDensity.compact,
          onPressed: () {
            setState(() {
              selectedChip = 'Losers';
            });
          },
          backgroundColor: selectedChip == 'Losers' ? Colors.grey[300] : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
            side: BorderSide(
              color: selectedChip == 'Losers' ? Colors.grey : Colors.black,
              width: selectedChip == 'Losers' ? 2 : 1,
            ),
          ),
        ),
      ],
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

  SliverGrid _buildStocksSliverGrid({required String whichStock}) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        final stock = whichStock == 'Most bought' ? stocksData[index] : stocksInNews[index];
        bool changeVal = stock['changeValue'] >= 0;
        return GridCardBuilder(stock: stock, changeVal: changeVal);
      }, childCount: stocksData.length),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  SliverGrid _buildTopMoversGrid(String selectedChip) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        final stock = selectedChip == 'Gainers'
            ? gainers[index]
            : losers[index];
        bool changeVal = stock['changeValue'] >= 0;
        return  GridCardBuilder(
          stock: stock,
          changeVal: changeVal,
        );
      },
          childCount: selectedChip == 'Gainers' ? gainers.length : losers.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  Column _buildToolIcon(String text, String imageUrl, VoidCallback onTap) {
    return Column(
      children: [
        IconButton(
          onPressed: onTap,
          icon: ImageIcon(AssetImage(imageUrl), size: 40, color: Colors.blue),
        ),
        Text(text),
      ],
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
