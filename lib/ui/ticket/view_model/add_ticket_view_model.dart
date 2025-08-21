import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/config/service_locator.dart';
import 'package:ticket_helpdesk/data/models/ticket_api.dart';
import 'package:ticket_helpdesk/data/repositories/ticket_repository.dart';
import 'package:ticket_helpdesk/data/repositories/user_repository.dart';
import 'package:ticket_helpdesk/domain/dto/ticket_request.dart';
import 'package:ticket_helpdesk/domain/models/name_info.dart';
import 'package:ticket_helpdesk/domain/models/ticket_category.dart';

class AddTicketViewModel extends ChangeNotifier {

  final UserRepository _userRepository = getIt<UserRepository>();
  final TicketRepository _ticketRepository = getIt<TicketRepository>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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

  /// Constructor: load dữ liệu ngay khi khởi tạo
  AddTicketViewModel() {
    loadInitialData();
  }

  /// Load category và user list
  Future<void> loadInitialData() async {
    try {
      categories = await _ticketRepository.fetchCategories();
      users = await _userRepository.fetchUsersNameInfo();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      loadingCategories = false;
      loadingUsers = false;
      notifyListeners();
    }
  }

  /// Cập nhật dropdown
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

    print(ticket.toJson());

    bool success = await saveTicket(ticket);
    if (success) {
      ScaffoldMessenger.of(context,).showSnackBar(
          const SnackBar(content: Text('Created ticket successfully!'))
      );
    } else {
      ScaffoldMessenger.of(context,).showSnackBar(
          SnackBar(content: Text('Error creating ticket'))
      );
    }
    return success;
  }
  @override
  void dispose() {
    titleController.dispose();
    dateTimeController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}