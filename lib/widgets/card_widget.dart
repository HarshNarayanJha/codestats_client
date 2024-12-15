import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key, required this.title, this.icon});

  final String title;
  final IconData? icon;


  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.amber,
      elevation: 6.0,
      // shadowColor: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(widget.icon),
                  Text(widget.title, style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w600))
                ]
              ),
            ],
          ),
      ),
    );
  }
}
