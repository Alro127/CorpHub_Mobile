import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_helpdesk/config/service_locator.dart';
import 'package:ticket_helpdesk/ui/core/widgets/basic_dropdown_field.dart';
import 'package:ticket_helpdesk/ui/core/widgets/basic_input.dart';
import 'package:ticket_helpdesk/ui/core/widgets/datetime_input.dart';
import 'package:ticket_helpdesk/ui/core/widgets/head_bar.dart';
import 'package:ticket_helpdesk/ui/ticket/view_model/add_ticket_view_model.dart';
import 'package:ticket_helpdesk/ui/ticket/widgets/ticket_action_buttons.dart';
import 'package:ticket_helpdesk/ui/ticket/widgets/ticket_category_and_priority.dart';
import 'package:ticket_helpdesk/ui/ticket/widgets/ticket_type_and_status.dart';

class AddNewTicket extends StatefulWidget {
  const AddNewTicket({super.key});

  @override
  State<AddNewTicket> createState() => _AddNewTicketState();
}

class _AddNewTicketState extends State<AddNewTicket> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddTicketViewModel(
        ticketUseCase: getIt(),
        userUseCases: getIt(),
      ),
      child: Consumer<AddTicketViewModel>(builder: (context, vm, _) {
        return Scaffold(
          appBar: HeadBar(title: "Add ticket"),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  BasicInput(
                    hintText: "Ticket's name",
                    prefixIcon: Icons.title_outlined,
                    linesNumber: 1,
                    controller: vm.titleController,
                  ),
                  const SizedBox(height: 16),
                  TicketCategoryAndPriority(vm: vm),
                  const SizedBox(height: 16),
                  TicketTypeAndStatus(vm: vm),
                  const SizedBox(height: 16),
                  vm.loadingUsers
                      ? const Center(child: CircularProgressIndicator())
                      : BasicDropdownField(
                    label: "Assigned to",
                    icon: Icons.person,
                    value: vm.assignedToId,
                    items: vm.users.map((user) {
                      return DropdownMenuItem(
                        value: user.id,
                        child: Text(user.fullName),
                      );
                    }).toList(),
                    onChanged: (value) => vm.setAssignedTo(value as int?),
                  ),
                  const SizedBox(height: 16),
                  DateTimeInput(
                    hintText: "Deadline",
                    icon: Icons.access_time,
                    controller: vm.dateTimeController,
                    onDateTimeChanged: (dateTime) {},
                  ),
                  const SizedBox(height: 16),
                  BasicInput(
                    hintText: "Description",
                    linesNumber: 5,
                    controller: vm.descriptionController,
                  ),
                  const SizedBox(height: 16),
                  TicketActionButtons(vm: vm),
                ],
              ),
            ),
          ),
        );
      }
      ),
    );
  }
}
