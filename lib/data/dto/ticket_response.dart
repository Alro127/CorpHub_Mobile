import 'package:ticket_helpdesk/const/ticket_prioriry.dart';
import 'package:ticket_helpdesk/const/ticket_status.dart';
import 'package:ticket_helpdesk/domain/models/department_basic_info.dart';
import 'package:ticket_helpdesk/domain/models/name_info.dart';
import 'package:ticket_helpdesk/domain/models/ticket_category.dart';

class TicketResponse {
  final int id;
  final String title;
  final String description;
  final TicketPriority priority;
  final TicketStatus status;
  final TicketCategory category;
  final NameInfo requester;
  final NameInfo? assignedTo;
  final String createdAt;
  final String updatedAt;
  final String? resolvedAt;
  final DepartmentBasicInfoDto? department;
  final DateTime? assignedAt;
  final bool active;

  TicketResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.category,
    required this.requester,
    this.assignedTo,
    required this.createdAt,
    required this.updatedAt,
    this.resolvedAt,
    this.department,
    this.assignedAt,
    required this.active,
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
      assignedTo: json['assignedTo'] != null
          ? NameInfo.fromJson(json['assignedTo'])
          : null,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      resolvedAt: json['resolvedAt'],
      department: json['department'] != null
          ? DepartmentBasicInfoDto.fromJson(json['department'])
          : null,
      assignedAt: json['assignedAt'] != null
          ? DateTime.tryParse(json['assignedAt'])
          : null,
      active: json['active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'status': status,
      'category': category.toJson(),
      'requester': requester.toJson(),
      'assignedTo': assignedTo?.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'resolvedAt': resolvedAt,
      'department': department?.toJson(),
      'assignedAt': assignedAt?.toIso8601String(),
      'active': active,
    };
  }
}
