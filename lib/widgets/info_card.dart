import 'package:flutter/material.dart';

class InfoCard extends StatefulWidget {
  bool _expanded = true;
  final String title;
  final List<Widget> children;
  InfoCard({required this.title, required this.children});
  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => widget._expanded = !widget._expanded);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Card(
            color: Colors.orange[100],
            child: ExpansionTile(
                title: Text(widget.title), children: widget.children)),
      ),
    );
  }
}
