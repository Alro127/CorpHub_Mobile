import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_helpdesk/config/service_locator.dart';
import 'package:ticket_helpdesk/ui/core/widgets/head_bar.dart';
import 'package:ticket_helpdesk/ui/core/widgets/side_bar.dart';
import 'package:ticket_helpdesk/ui/my_tickets/view_model/my_tickets_view_model.dart';
import 'package:ticket_helpdesk/ui/my_tickets/widgets/search_bar.dart';
import 'package:ticket_helpdesk/ui/my_tickets/widgets/ticket_list.dart';
import 'package:ticket_helpdesk/ui/ticket/view/add_ticket_screen.dart';

class MyTicketsPage extends StatelessWidget {
  const MyTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyTicketsViewModel>(
      create: (_) => getIt<MyTicketsViewModel>(),
      child: Consumer<MyTicketsViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            appBar: HeadBar(title: "My Tickets"),
            drawer: SideBar(),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBarWidget(onChanged: vm.setSearchText),
                //DashboardStats(),
                DefaultTabController(
                  length: 3,
                  child: Expanded(
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: Colors.blueAccent,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.blueAccent,
                          tabs: const [
                            Tab(text: "All Tickets"),
                            Tab(text: "Request"),
                            Tab(text: "Assigned to"),
                          ],
                        ),
                        Expanded(
                          // chiều cao TabBarView, có thể dùng MediaQuery hoặc Expanded
                          child: TabBarView(
                            children: [
                              // Tab 1: tất cả ticket
                              vm.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : TicketList(
                                      tickets: vm.filteredTickets,
                                      onDelete: vm.deleteTicket,
                                    ),

                              // Tab 2: Request
                              vm.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : TicketList(
                                      tickets: vm.filteredTickets
                                          .where(
                                            (t) =>
                                                t.requester.id ==
                                                vm.currentUserId,
                                          )
                                          .toList(),
                                      onDelete: vm.deleteTicket,
                                    ),
                              vm.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : TicketList(
                                      tickets: vm.filteredTickets
                                          .where(
                                            (t) =>
                                                t.assignee?.id ==
                                                vm.currentUserId,
                                          )
                                          .toList(),
                                      onDelete: vm.deleteTicket,
                                    ),
                            ],
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
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
