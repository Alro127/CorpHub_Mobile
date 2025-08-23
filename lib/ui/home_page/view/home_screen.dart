import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:ticket_helpdesk/config/service_locator.dart';
import 'package:ticket_helpdesk/ui/core/widgets/head_bar.dart';
import 'package:ticket_helpdesk/ui/core/widgets/side_bar.dart';
import 'package:ticket_helpdesk/ui/home_page/view_model/home_view_model.dart';
import 'package:ticket_helpdesk/ui/home_page/widgets/dashboard_stats.dart';
import 'package:ticket_helpdesk/ui/home_page/widgets/search_bar.dart';
import 'package:ticket_helpdesk/ui/home_page/widgets/ticket_list.dart';
import 'package:ticket_helpdesk/ui/ticket/view/add_ticket_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => getIt<HomeViewModel>(),
      child: Consumer<HomeViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            appBar: HeadBar(title: "Home Page"),
            drawer: SideBar(),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBarWidget(onChanged: vm.setSearchText),
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
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: vm.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : TicketList(
                                  tickets: vm.filteredTickets,
                                  onDelete: vm.deleteTicket,
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
