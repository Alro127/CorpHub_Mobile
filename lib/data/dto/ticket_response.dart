import 'package:ticket_helpdesk/const/ticket_prioriry.dart';
import 'package:ticket_helpdesk/const/ticket_status.dart';
import 'package:ticket_helpdesk/data/dto/department_dto.dart';
import 'package:ticket_helpdesk/data/dto/name_info.dart';
import 'package:ticket_helpdesk/data/dto/ticket_category.dart';

class TicketResponse {
  final String id;
  final String title;
  String description;
  final TicketPriority priority;
  TicketStatus status;
  final TicketCategory category;
  final NameInfo requester;
  final NameInfo? assignee;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? resolvedAt;
  final DepartmentDto? department;
  final DateTime? assignedAt;

  TicketResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.category,
    required this.requester,
    this.assignee,
    required this.createdAt,
    required this.updatedAt,
    this.resolvedAt,
    this.department,
    this.assignedAt,
  });

  factory TicketResponse.fromJson(Map<String, dynamic> json) {
    return TicketResponse(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      priority: TicketPriority.values.firstWhere(
        (e) => e.name == json['priority'],
        orElse: () => TicketPriority.LOW,
      ),
      status: TicketStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TicketStatus.WAITING,
      ),
      category: TicketCategory.fromJson(json['category']),
      requester: NameInfo.fromJson(json['requester']),
      assignee: json['assignee'] != null
          ? NameInfo.fromJson(json['assignee'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      resolvedAt: json['resolvedAt'] != null
          ? (json['resolvedAt'] is String
                ? DateTime.parse(json['resolvedAt'])
                : DateTime.tryParse(json['resolvedAt'].toString()))
          : null,

      department: json['department'] != null
          ? DepartmentDto.fromJson(json['department'])
          : null,
      assignedAt: json['assignedAt'] != null
          ? DateTime.tryParse(json['assignedAt'])
          : null,
    );
  }

  TicketResponse? copyWith({required String description}) {
    return null;
  }
}
