import 'package:flutter/material.dart';


class TicketItem extends StatefulWidget {
  const TicketItem ({super.key});

  @override
  State<TicketItem> createState() => _State();
}

class _State extends State<TicketItem> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mã ticket + trạng thái + ưu tiên
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Mã ticket",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
                Row(
                  children: [
                    Chip(
                      label: Text("Trạng thái"),
                      backgroundColor: Colors.greenAccent,
                      labelStyle: TextStyle(
                        color: Colors.green
                      ),
                    ),
                    SizedBox(width: 6,),
                    Chip(
                      label: Text("Độ ưu tiên"),
                      backgroundColor: Colors.grey,
                      labelStyle:
                      TextStyle(
                          color: Colors.white,
                          fontSize: 12),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Divider(),
            Text(
              "Tiêu đề",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),
            ),
            const Divider(),
            // Thời gian
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                        Icons.calendar_month,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 6,),
                    Text(
                      "Thời gian tạo",
                      style: const TextStyle(
                          fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                        Icons.hourglass_bottom,
                      color: Colors.yellow,
                    ),
                    const SizedBox(width: 6,),
                    Text(
                        "Thời gian còn lại",
                        style: const TextStyle(
                            fontSize: 12,
                        )
                    )
                  ],
                ),

              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.person),
                Text("Người yêu cầu")
              ],
            ),
            Row(
              children: [
                Icon(Icons.engineering),
                Text("Kỹ thuật viên")
              ],
            ),
            const Divider(),
          ],
        ),
      )
    );
  }
}
