class TicketCategory {
  final int id;
  final String name;

  TicketCategory({required this.id, required this.name});

  factory TicketCategory.fromJson(Map<String, dynamic> json) {
    return TicketCategory(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
