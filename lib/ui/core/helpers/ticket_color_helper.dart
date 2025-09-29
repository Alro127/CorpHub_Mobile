import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/const/ticket_prioriry.dart';
import 'package:ticket_helpdesk/const/ticket_status.dart';

class TicketColorHelper {
  static Color getStatusColor(TicketStatus status) {
    switch (status) {
      case TicketStatus.WAITING:
        return Colors.orange; // đang xác nhận của phòng ban yêu cầu
      case TicketStatus.ASSIGNING:
        return Colors.blue; // đã chấp nhận
      case TicketStatus.REJECTED:
        return Colors.red; // bị từ chối
      case TicketStatus.OPEN:
        return Colors.grey; // chờ xác nhận từ phòng ban của requester
      case TicketStatus.IN_PROGRESS:
        return Colors.purple; // assignee chấp nhận
      case TicketStatus.DONE:
        return Colors.green; // hoàn thành
    }
  }

  static Color getPriorityColor(TicketPriority priority) {
    switch (priority) {
      case TicketPriority.LOW:
        return Colors.green; // nhẹ, dễ chịu
      case TicketPriority.MEDIUM:
        return Colors.blue; // trung bình
      case TicketPriority.HIGH:
        return Colors.orange; // cảnh báo
      case TicketPriority.URGENT:
        return Colors.red; // khẩn cấp
    }
  }
}
