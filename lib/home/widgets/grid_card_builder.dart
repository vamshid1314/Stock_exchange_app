import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GridCardBuilder extends StatelessWidget{

  final Map<String,dynamic> stock ;
  final bool changeVal ;

  const GridCardBuilder({super.key, required this.stock, required this.changeVal});

  @override
  Widget build(BuildContext context) {
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
  }

}