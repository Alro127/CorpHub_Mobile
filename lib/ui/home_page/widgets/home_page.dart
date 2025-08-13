import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/core/widgets/ticket_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('HomePage')),
      body: TicketItem(),
    );
  }
}
