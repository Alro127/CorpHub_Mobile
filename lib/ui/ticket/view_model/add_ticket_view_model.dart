import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/const/ticket_prioriry.dart';
import 'package:ticket_helpdesk/const/ticket_status.dart';
import 'package:ticket_helpdesk/data/dto/ticket_request.dart';
import 'package:ticket_helpdesk/domain/models/department_basic_info.dart';
import 'package:ticket_helpdesk/domain/models/ticket_category.dart';
import 'package:ticket_helpdesk/domain/usecases/department_usecase.dart';
import 'package:ticket_helpdesk/domain/usecases/ticket_usecases.dart';

class AddTicketViewModel extends ChangeNotifier {
  final TicketUseCase _ticketUseCase;
  final DepartmentUsecase _departmentUsecase;

  AddTicketViewModel({
    required TicketUseCase ticketUseCase,
    required DepartmentUsecase departmentUsecase,
  }) : _ticketUseCase = ticketUseCase,
       _departmentUsecase = departmentUsecase {
    loadInitialData();
  }

  // Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Ticket properties
  TicketPriority priority = TicketPriority.MEDIUM;
  TicketStatus status = TicketStatus.WAITING;
  String ticketType = "Request";
  DateTime deadline = DateTime.now();

  List<TicketCategory> categories = [];
  List<DepartmentBasicInfoDto> departments = [];
  int? selectedCategoryId;
  int? assignedToId;
  int departmentId = 1;

  bool loadingCategories = true;
  bool loadingUsers = true;
  String? errorMessage;

  /// Load category và user list
  Future<void> loadInitialData() async {
    try {
      categories = await _ticketUseCase.fetchCategories();
      departments = await _departmentUsecase.fetchDepartment();
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

  void setPriority(TicketPriority value) {
    priority = value;
    notifyListeners();
  }

  void setStatus(TicketStatus value) {
    status = value;
    notifyListeners();
  }

  void setTicketType(String value) {
    ticketType = value;
    notifyListeners();
  }

  Future<bool> saveTicketAction(BuildContext context) async {
    final ticket = TicketRequest(
      id: null,
      title: titleController.text,
      description: descriptionController.text,
      priority: priority.name,
      categoryId: selectedCategoryId ?? 0,
      requesterId: 1,
      //      assignedToId: assignedToId,
      departmentId: departmentId,
    );

    bool success = await _saveTicket(ticket);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Created ticket successfully!')),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error creating ticket')));
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
