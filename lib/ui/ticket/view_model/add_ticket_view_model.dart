import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/domain/dto/ticket_request.dart';
import 'package:ticket_helpdesk/domain/models/name_info.dart';
import 'package:ticket_helpdesk/domain/models/ticket_category.dart';
import 'package:ticket_helpdesk/data/repositories/ticket_repository.dart';
import 'package:ticket_helpdesk/data/repositories/user_repository.dart';
import 'package:ticket_helpdesk/domain/usecases/ticket_usecases.dart';
import 'package:ticket_helpdesk/domain/usecases/user_usecases.dart';

class AddTicketViewModel extends ChangeNotifier {
  final TicketUseCase _ticketUseCase;
  final UserUseCases _userUseCases;

  AddTicketViewModel({
    required TicketUseCase ticketUseCase,
    required UserUseCases userUseCases,
  })  : _ticketUseCase = ticketUseCase,
        _userUseCases = userUseCases {
    loadInitialData();
  }

  // Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Ticket properties
  String priority = 'low';
  String status = 'open';
  String ticketType = "Request";
  DateTime deadline = DateTime.now();

  List<TicketCategory> categories = [];
  List<NameInfo> users = [];
  int? selectedCategoryId;
  int? assignedToId;

  bool loadingCategories = true;
  bool loadingUsers = true;
  String? errorMessage;

  /// Load category và user list
  Future<void> loadInitialData() async {
    try {
      categories = await _ticketUseCase.fetchCategories();
      users = await _userUseCases.fetchUsersNameInfo();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      loadingCategories = false;
      loadingUsers = false;
      notifyListeners();
    }
  }

  // Dropdown setters
  void setCategory(int? id) {
    selectedCategoryId = id;
    notifyListeners();
  }

  void setAssignedTo(int? id) {
    assignedToId = id;
    notifyListeners();
  }

  void setPriority(String value) {
    priority = value;
    notifyListeners();
  }

  void setStatus(String value) {
    status = value;
    notifyListeners();
  }

  void setTicketType(String value) {
    ticketType = value;
    notifyListeners();
  }

  Future<bool> saveTicketAction(BuildContext context) async {
    final ticket = TicketRequest(
      id: -1,
      title: titleController.text,
      description: descriptionController.text,
      priority: priority,
      status: status,
      categoryId: selectedCategoryId ?? 0,
      requesterId: 1,
      assignedToId: assignedToId,
    );

    bool success = await _saveTicket(ticket);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Created ticket successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error creating ticket')),
      );
    }
    return success;
  }

  Future<bool> _saveTicket(TicketRequest ticket) async {
    try {
      return await _ticketUseCase.saveTicket(ticket);
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    dateTimeController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
