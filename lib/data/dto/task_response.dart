import 'package:ticket_helpdesk/const/ticket_prioriry.dart';
import 'package:ticket_helpdesk/const/ticket_status.dart';
import 'package:ticket_helpdesk/data/dto/project_response.dart';
import 'package:ticket_helpdesk/domain/models/name_info.dart';
import 'package:ticket_helpdesk/domain/models/ticket_category.dart';

class TaskResponse {
  final String id;
  final String title;
  final String description;
  final TicketPriority priority;
  final TicketStatus status;
  final TicketCategory category;
  final NameInfo requester;
  final NameInfo? assignee;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? resolvedAt;
  final ProjectResponse project;
  final DateTime? assignedAt;

  TaskResponse({
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
    required this.project,
    this.assignedAt,
  });

  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    return TaskResponse(
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

      project: ProjectResponse.fromJson(json['department']),
      assignedAt: json['assignedAt'] != null
          ? DateTime.tryParse(json['assignedAt'])
          : null,
    );
  }
}
