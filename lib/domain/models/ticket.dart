class Ticket {
  String _ticketId;
  String _title;
  int _status;
  int _priority;
  String _type;
  String _category;
  String _requester;
  String _technician;
  String _createdDate;
  String _deadline;
  int _attachments;

  Ticket({
    required String ticketId,
    required String title,
    required int status,
    required int priority,
    required String type,
    required String category,
    required String requester,
    required String technician,
    required String createdDate,
    required String deadline,
    required int attachments,
  }) : _ticketId = ticketId,
       _title = title,
       _status = status,
       _priority = priority,
       _type = type,
       _category = category,
       _requester = requester,
       _technician = technician,
       _createdDate = createdDate,
       _deadline = deadline,
       _attachments = attachments;

  // Getters
  String get ticketId => _ticketId;
  String get title => _title;
  int get status => _status;
  int get priority => _priority;
  String get type => _type;
  String get category => _category;
  String get requester => _requester;
  String get technician => _technician;
  String get createdDate => _createdDate;
  String get deadline => _deadline;
  int get attachments => _attachments;

  // Setters
  set ticketId(String value) => _ticketId = value;
  set title(String value) => _title = value;
  set status(int value) => _status = value;
  set priority(int value) => _priority = value;
  set type(String value) => _type = value;
  set category(String value) => _category = value;
  set requester(String value) => _requester = value;
  set technician(String value) => _technician = value;
  set createdDate(String value) => _createdDate = value;
  set deadline(String value) => _deadline = value;
  set attachments(int value) => _attachments = value;
}
