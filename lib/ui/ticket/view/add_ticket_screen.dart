import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_helpdesk/config/service_locator.dart';
import 'package:ticket_helpdesk/ui/core/widgets/basic_dropdown_field.dart';
import 'package:ticket_helpdesk/ui/core/widgets/basic_input.dart';
import 'package:ticket_helpdesk/ui/core/widgets/head_bar.dart';
import 'package:ticket_helpdesk/ui/ticket/view_model/add_ticket_view_model.dart';
import 'package:ticket_helpdesk/ui/ticket/widgets/ticket_action_buttons.dart';
import 'package:ticket_helpdesk/ui/ticket/widgets/ticket_category_and_priority.dart';

class AddNewTicket extends StatefulWidget {
  const AddNewTicket({super.key});

  @override
  State<AddNewTicket> createState() => _AddNewTicketState();
}

class _AddNewTicketState extends State<AddNewTicket> {
  // FocusNode nullable, tránh lỗi LateInitializationError
  FocusNode? focusNodeTitle;
  FocusNode? focusNodeDescription;
  FocusNode? focusNodeDepartment;

  @override
  void initState() {
    super.initState();
    focusNodeTitle = FocusNode();
    focusNodeDescription = FocusNode();
    focusNodeDepartment = FocusNode();
  }

  @override
  void dispose() {
    focusNodeTitle?.dispose();
    focusNodeDescription?.dispose();
    focusNodeDepartment?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddTicketViewModel(
        ticketUseCase: getIt(),
        departmentUsecase: getIt(),
      ),
      child: Consumer<AddTicketViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            appBar: HeadBar(title: "Add ticket"),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Tiêu đề ticket
                    BasicInput(
                      hintText: "Ticket's title",
                      prefixIcon: Icons.title_outlined,
                      linesNumber: 1,
                      controller: vm.titleController,
                      focusNode: focusNodeTitle,
                    ),
                    const SizedBox(height: 16),

                    // Category & Priority
                    TicketCategoryAndPriority(vm: vm),
                    const SizedBox(height: 16),

                    // Department dropdown
                    vm.loadingUsers
                        ? const Center(child: CircularProgressIndicator())
                        : Focus(
                            focusNode: focusNodeDepartment,
                            child: BasicDropdownField<String>(
                              label: "Department",
                              icon: Icons.apartment,
                              value: vm.departmentId,
                              items: vm.departments.map((department) {
                                return DropdownMenuItem(
                                  value: department.id,
                                  child: Text(department.name),
                                );
                              }).toList(),
                              onChanged: (value) => vm.setAssignedTo(value),
                            ),
                          ),
                    const SizedBox(height: 16),

                    // Mô tả ticket
                    BasicInput(
                      hintText: "Description",
                      linesNumber: 5,
                      controller: vm.descriptionController,
                      focusNode: focusNodeDescription,
                    ),
                    const SizedBox(height: 16),

                    // Buttons
                    TicketActionButtons(vm: vm),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
