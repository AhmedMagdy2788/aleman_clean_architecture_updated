import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final String subTitle;
  const PageHeader({required this.title, required this.subTitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Text(
            subTitle,
            style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18,
                color: Color(0xFFA5D6A7)),
          )
        ],
      ),
    );
  }
}
