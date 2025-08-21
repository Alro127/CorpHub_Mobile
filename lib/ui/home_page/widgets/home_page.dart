import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ticket_helpdesk/data/models/ticket_api.dart';
import 'package:ticket_helpdesk/domain/dto/ticket_response.dart';
import 'package:ticket_helpdesk/ui/core/widgets/head_bar.dart';
import 'package:ticket_helpdesk/ui/core/widgets/side_bar.dart';
import 'package:ticket_helpdesk/ui/core/widgets/ticket_item.dart';
import 'package:ticket_helpdesk/ui/home_page/widgets/dashboard_stats.dart';
import 'package:ticket_helpdesk/ui/ticket/view/add_ticket_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<TicketResponse>> tickets;

  @override
  void initState() {
    super.initState();
    tickets = fetchTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeadBar(title: "Home Page"),
      drawer: SideBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchBarWidget(),
          DashboardStats(),
          Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent tickets',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: FutureBuilder<List<TicketResponse>>(
                      future: tickets,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('No tickets found.'));
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final ticket = snapshot.data![index];

                              return Slidable(
                                key: ValueKey(ticket.id),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  extentRatio:
                                      0.25, // chỉ kéo ra 25% chiều rộng
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) async {
                                        final confirm = await showDialog<bool>(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text("Xác nhận"),
                                            content: Text(
                                              "Bạn có chắc muốn xoá ticket '${ticket.title}'?",
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.of(
                                                  context,
                                                ).pop(false),
                                                child: Text("Hủy"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(
                                                    context,
                                                  ).pop(true);
                                                },
                                                child: Text(
                                                  "Xóa",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );

                                        if (confirm == true) {
                                          final isDeleted = await deleteTicket(
                                            ticket.id,
                                          );

                                          if (isDeleted) {
                                            setState(() {
                                              snapshot.data!.removeAt(index);
                                            });
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                elevation: 8,
                                                content: Text(
                                                  "Đã xoá '${ticket.title}'",
                                                ),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Xoá thất bại, vui lòng thử lại",
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Xóa',
                                    ),
                                  ],
                                ),
                                child: TicketItem(ticket: ticket),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => AddNewTicket()));
        },
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(50)),
        ),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget SearchBarWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search ticket...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        onChanged: (value) {},
      ),
    );
  }
}
