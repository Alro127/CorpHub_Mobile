import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/data/dto/ticket_rejection_dto.dart';
import 'package:ticket_helpdesk/data/dto/ticket_request.dart';
import 'package:ticket_helpdesk/data/dto/ticket_response.dart';
import 'package:ticket_helpdesk/data/local/secure_storage_service.dart';
import 'package:ticket_helpdesk/domain/usecases/ticket_usecases.dart';

class TicketDetailsViewModel extends ChangeNotifier {
  late final _ticketUseCase;
  late final SecureStorageService _storageService;
  bool isEditing = false;
  final TextEditingController descriptionController = TextEditingController();
  String? _originalDescription;

  TicketDetailsViewModel({
    required TicketUseCase ticketUseCase,
    required SecureStorageService storageService,
    TicketResponse? initialTicket,
  }) {
    _ticketUseCase = ticketUseCase;
    _storageService = storageService;
    ticket = initialTicket;
    if (ticket != null) {
      descriptionController.text = ticket!.description;
    }
  }

  void toggleEdit() {
    if (isEditing) {
      // tắt chế độ edit
      isEditing = false;
    } else {
      // bật chế độ edit → lưu lại giá trị gốc
      _originalDescription = descriptionController.text;
      isEditing = true;
    }
    notifyListeners();
  }

  void cancelEdit() {
    // restore giá trị gốc
    descriptionController.text =
        _originalDescription ?? descriptionController.text;
    isEditing = false;
    notifyListeners();
  }

  TicketResponse? ticket;
  bool isLoading = false;
  String? errorMessage;
  String? _currentUserId;
  String? get currentUserId => _currentUserId;

  Future<void> loadCurrentUserId() async {
    _currentUserId = await _storageService.getMyId();
    notifyListeners();
  }

  final TextEditingController rejectReasonController = TextEditingController();

  /// Accept ticket
  Future<bool> acceptTicket() async {
    if (ticket == null) return false;
    isLoading = true;
    notifyListeners();

    try {
      return await _ticketUseCase.acceptTicket(ticket!.id);
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> saveEdit() async {
    final newDesc = descriptionController.text.trim();
    TicketRequest ticketRequest = TicketRequest(
      id: ticket!.id,
      title: ticket!.title,
      description: newDesc,
      priority: ticket!.priority,
      categoryId: ticket!.category.id,
      departmentId: ticket!.department!.id,
    );
    final updated = await _ticketUseCase.saveTicket(ticketRequest);
    if (updated) {
      ticket = ticket!.copyWith(description: newDesc); 
      isEditing = false;
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Reject ticket
  Future<bool> rejectTicket(String reason) async {
    if (ticket == null) return false;
    isLoading = true;
    notifyListeners();

    try {
      return await _ticketUseCase.rejectTicket(
        TicketRejectionDto(ticketId: ticket!.id, reason: reason),
      );
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> completeTicket() async {
    if (ticket == null) return false;
    isLoading = true;
    notifyListeners();

    try {
      return await _ticketUseCase.completeTicket(ticket!.id);
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    rejectReasonController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
