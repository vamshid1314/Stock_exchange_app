import 'package:flutter/material.dart';

class IndicesCard extends StatelessWidget {
  final Map stock;

  const IndicesCard({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final stockChange = stock['change'] >= 0;

    return Center(
      child: Card(
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stock['name'],
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                      stock['points'].toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "${stockChange ? '+' : ''}${stock['change']} (${stock['percent']}%)",
                      style: TextStyle(
                        color: stockChange ? Colors.green : Colors.red,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
