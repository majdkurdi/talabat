import 'package:flutter/material.dart';
import '../modals/order.dart';

class OrderCard extends StatefulWidget {
  final Order order;

  OrderCard(this.order);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    DateTime deliveryTime = widget.order.date.add(Duration(days: 15));
    int deliveryDuration = deliveryTime.difference(widget.order.date).inDays;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon:
                      Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Text(
                        'Order ID: ${widget.order.id}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        'Total: ${widget.order.total}\$',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        'Date: ${widget.order.date}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (_isExpanded)
              Column(
                children: [
                  ListView.builder(
                    itemBuilder: (ctx, i) => ListTile(
                      leading: Text('${i + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      title: Text(widget.order.items[i].title),
                      trailing: Text(
                          '${widget.order.items[i].price}\$   X${widget.order.items[i].quantity}'),
                    ),
                    itemCount: widget.order.items.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
