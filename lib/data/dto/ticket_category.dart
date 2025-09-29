class TicketCategory {
  final String id;
  final String categoryName;

  TicketCategory({required this.id, required this.categoryName});

  factory TicketCategory.fromJson(Map<String, dynamic> json) {
    return TicketCategory(id: json['id'], categoryName: json['categoryName']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'categoryName': categoryName};
  }
}
