import 'package:ticket_helpdesk/domain/models/name_info.dart';
import 'package:ticket_helpdesk/domain/models/ticket_category.dart';

class TicketResponse {
  final int id;
  final String title;
  final String description;
  final String priority;
  final String status;
  final TicketCategory category;
  final NameInfo requester;
  final NameInfo? assignedTo;
  final String createdAt;
  final String updatedAt;
  final String? resolvedAt;

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
  });

  factory TicketResponse.fromJson(Map<String, dynamic> json) {
    return TicketResponse(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      priority: json['priority'],
      status: json['status'],
      category: TicketCategory.fromJson(json['category']),
      requester: NameInfo.fromJson(json['requester']),
      assignedTo: json['assignedTo'] != null
          ? NameInfo.fromJson(json['assignedTo'])
          : null,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      resolvedAt: json['resolvedAt'],
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
    };
  }
}
