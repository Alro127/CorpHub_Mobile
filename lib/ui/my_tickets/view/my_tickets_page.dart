import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_helpdesk/config/service_locator.dart';
import 'package:ticket_helpdesk/const/ticket_status.dart';
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
                  length: 2,
                  child: Expanded(
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: Colors.blueAccent,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.blueAccent,
                          tabs: const [
                            Tab(text: "Your Requests"),
                            Tab(text: "Assigned to you"),
                          ],
                        ),
                        Expanded(
                          // chiều cao TabBarView, có thể dùng MediaQuery hoặc Expanded
                          child: TabBarView(
                            children: [
                              // Tab 1: Request
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
                              // Tab 2: Assigned to you
                              vm.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : DefaultTabController(
                                      length: 3,
                                      child: Column(
                                        children: [
                                          TabBar(
                                            labelColor: Colors.blueAccent,
                                            unselectedLabelColor: Colors.grey,
                                            indicatorColor: Colors.blueAccent,
                                            tabs: const [
                                              Tab(text: "Assigning"),
                                              Tab(text: "In Progress"),
                                              Tab(text: "Done"),
                                            ],
                                          ),
                                          Expanded(
                                            child: TabBarView(
                                              children: [
                                                // Chờ
                                                TicketList(
                                                  tickets: vm.filteredTickets
                                                      .where(
                                                        (t) =>
                                                            t.assignee?.id ==
                                                                vm.currentUserId &&
                                                            t.status ==
                                                                TicketStatus
                                                                    .ASSIGNING,
                                                      )
                                                      .toList(),
                                                  onDelete: vm.deleteTicket,
                                                ),
                                                // Nhận
                                                TicketList(
                                                  tickets: vm.filteredTickets
                                                      .where(
                                                        (t) =>
                                                            t.assignee?.id ==
                                                                vm.currentUserId &&
                                                            t.status ==
                                                                TicketStatus
                                                                    .IN_PROGRESS,
                                                      )
                                                      .toList(),
                                                  onDelete: vm.deleteTicket,
                                                ),
                                                // Xong
                                                TicketList(
                                                  tickets: vm.filteredTickets
                                                      .where(
                                                        (t) =>
                                                            t.assignee?.id ==
                                                                vm.currentUserId &&
                                                            t.status ==
                                                                TicketStatus
                                                                    .DONE,
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
              onPressed: () async {
                final result = await Navigator.of(context).push<bool>(
                  MaterialPageRoute(builder: (context) => const AddNewTicket()),
                );

                if (result == true) {
                  // Lấy lại ViewModel và fetch
                  final vm = context.read<MyTicketsViewModel>();
                  vm.fetchTickets();
                }
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
