import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_helpdesk/config/service_locator.dart';
import 'package:ticket_helpdesk/const/ticket_status.dart';
import 'package:ticket_helpdesk/data/dto/ticket_response.dart';
import 'package:ticket_helpdesk/data/local/secure_storage_service.dart';
import 'package:ticket_helpdesk/domain/usecases/ticket_usecases.dart';
import 'package:ticket_helpdesk/ui/core/helpers/datetime_helper.dart';
import 'package:ticket_helpdesk/ui/core/helpers/ticket_color_helper.dart';
import 'package:ticket_helpdesk/ui/profile/widgets/editable_field.dart';
import 'package:ticket_helpdesk/ui/ticket/view_model/ticket_details_view_model.dart';

class TicketDetailsView extends StatelessWidget {
  final TicketResponse ticket;
  const TicketDetailsView({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TicketDetailsViewModel>(
      create: (_) {
        final vm = TicketDetailsViewModel(
          ticketUseCase: getIt<TicketUseCase>(),
          storageService: getIt<SecureStorageService>(),
          initialTicket: ticket,
        );
        vm.loadCurrentUserId();
        return vm;
      },
      child: Consumer<TicketDetailsViewModel>(
        builder: (context, vm, _) {
          final statusColor = TicketColorHelper.getStatusColor(
            vm.ticket!.status,
          );
          final textTheme = Theme.of(context).textTheme;

          return Scaffold(
            backgroundColor: Colors.black54,
            body: Center(
              child: Hero(
                tag: "ticket_${ticket.id}",
                child: Material(
                  color: Colors.transparent,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 32,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 6,
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          // Header
                          Container(
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.9),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "#${vm.ticket!.id.substring(0, 6)}",
                                  style: textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      vm.ticket!.status.name,
                                      style: textTheme.labelMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Body content scrollable
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(16),
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title
                                  Text(
                                    vm.ticket!.title,
                                    style: textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                      height: 1.3,
                                    ),
                                  ),
                                  const SizedBox(height: 14),

                                  _highlightInfo(
                                    Icons.person,
                                    "Requester: ${vm.ticket!.requester.fullName}",
                                    textTheme,
                                  ),
                                  _highlightInfo(
                                    Icons.engineering,
                                    "Assignee: ${vm.ticket!.assignee?.fullName ?? 'Chưa phân công'}",
                                    textTheme,
                                  ),

                                  const SizedBox(height: 12),

                                  // Priority + Category + UpdatedAt
                                  Row(
                                    children: [
                                      _iconTagChip(
                                        Icons.flag,
                                        vm.ticket!.priority.name,
                                        TicketColorHelper.getPriorityColor(
                                          vm.ticket!.priority,
                                        ),
                                        textTheme,
                                      ),
                                      const SizedBox(width: 8),
                                      _iconTagChip(
                                        Icons.category,
                                        vm.ticket!.category.categoryName,
                                        Colors.pinkAccent,
                                        textTheme,
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.update,
                                            size: 16,
                                            color: Colors.grey[600],
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            DateTimeHelper.format(
                                              vm.ticket!.updatedAt,
                                            ),
                                            style: textTheme.bodySmall
                                                ?.copyWith(
                                                  color: Colors.black87,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const Divider(height: 28),

                                  // Description
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Description",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey[300]!,
                                          ),
                                        ),
                                        child: EditableField(
                                          controller: vm.descriptionController,
                                          isEditing: vm.isEditing,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const Divider(height: 28),

                                  // Attachments
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Attachments",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey[300]!,
                                          ),
                                        ),
                                        child: const Text(
                                          "File đính kèm sẽ hiển thị ở đây...",
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Action Buttons luôn dính dưới
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: _buildActionButtons(context, vm),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _highlightInfo(IconData icon, String text, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[700]),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconTagChip(
    IconData icon,
    String label,
    Color color,
    TextTheme textTheme,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, TicketDetailsViewModel vm) {
    final ticket = vm.ticket;
    final currentUserId = vm.currentUserId;
    if (currentUserId == null) return const SizedBox.shrink();

    final buttons = <Widget>[];
    if (ticket?.assignee?.id == currentUserId &&
        ticket?.status == TicketStatus.ASSIGNING) {
      buttons.addAll([
        _buildActionButton("Accept", Colors.green, () async {
          final success = await vm.acceptTicket();
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(success ? 'Ticket accepted!' : 'Error')),
            );
            if (success) Navigator.pop(context, true);
          }
        }),
        const SizedBox(width: 10),
        _buildActionButton("Reject", Colors.red, () async {
          String reason = "";
          final result = await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: const Text("Reject Ticket"),
                content: TextField(
                  onChanged: (v) => reason = v,
                  controller: vm.rejectReasonController,
                  decoration: const InputDecoration(
                    hintText: "Enter rejection reason",
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final success = await vm.rejectTicket(reason);
                      if (context.mounted) Navigator.of(context).pop(success);
                    },
                    child: const Text("Submit"),
                  ),
                ],
              );
            },
          );

          if (result == true && context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Ticket rejected!')));
            Navigator.of(context).pop(true);
          }
        }),
      ]);
    } else if (ticket?.assignee?.id == currentUserId &&
        ticket?.status == TicketStatus.IN_PROGRESS) {
      buttons.add(
        _buildActionButton("Complete", Colors.blue, () async {
          final success = await vm.completeTicket();
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(success ? 'Ticket completed!' : 'Error')),
            );
            if (success) Navigator.pop(context, true);
          }
        }),
      );
    } else if (ticket?.requester.id == currentUserId &&
        ticket?.status == TicketStatus.OPEN) {
      if (vm.isEditing) {
        buttons.addAll([
          _buildActionButton("Save", Colors.green, () async {
            final success = await vm.saveEdit();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    success ? 'Updated successfully!' : 'Update failed',
                  ),
                ),
              );
            }
          }),
          const SizedBox(width: 8),
          _buildActionButton("Cancel", Colors.grey, vm.cancelEdit),
        ]);
      } else {
        buttons.add(_buildActionButton("Edit", Colors.orange, vm.toggleEdit));
      }
    }

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: buttons);
  }

  Widget _buildActionButton(String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.9),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
    );
  }
}
