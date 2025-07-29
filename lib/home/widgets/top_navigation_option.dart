import 'package:flutter/material.dart';

class TopNavigationOption extends StatefulWidget{
  final String option;
  final bool isSelected;
  final VoidCallback onTap;

  const TopNavigationOption({
    super.key,
    required this.option, required this.isSelected, required this.onTap
  });

  @override
  State<TopNavigationOption> createState() => _TopNavigationOptionState();
}

class _TopNavigationOptionState extends State<TopNavigationOption> {

  @override
  Widget build(BuildContext context) {
   return GestureDetector(
     onTap: widget.onTap,
     child: Container(
       decoration: BoxDecoration(
           border: Border(
               bottom: widget.isSelected
                   ?const BorderSide(width: 2, color: Colors.black)
                   :BorderSide.none
           )
       ),
       child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: Text(
           widget.option,
           style: Theme.of(context).textTheme.titleLarge,
         ),
       ),
     ),
   );
  }
}