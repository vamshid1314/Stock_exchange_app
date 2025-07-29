import 'package:flutter/material.dart';

class IndicesCard extends StatelessWidget{
  final Map stock;

  const IndicesCard({
    super.key,
    required this.stock
  });

  @override
  Widget build(BuildContext context) {
    final stockChange = stock['change'] >= 0;
    return Card(
      child: ListTile(
        title: Text(
          stock['name'],
        ),
        subtitle: Row(
          children: [
            Text(stock['points'].toString()),

            const SizedBox(width:10),
            if(stockChange)
              const Text('+', style: TextStyle(color: Colors.green),)
            else
              const Text('-',  style: TextStyle(color: Colors.red)),

            Expanded(
              child: Text(
                "${stock['change']}(${stock['percent']}%)",
                style: TextStyle(
                    color: stockChange ? Colors.green : Colors.red
                ),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}