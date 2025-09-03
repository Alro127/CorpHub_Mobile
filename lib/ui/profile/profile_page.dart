import 'package:flutter/material.dart';
import 'dart:math';
import 'package:ticket_helpdesk/ui/core/widgets/head_bar.dart';
import 'package:ticket_helpdesk/ui/core/widgets/side_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  // 🔹 Controller cho các field
  final TextEditingController _nameController = TextEditingController(
    text: "John Doe",
  );
  final TextEditingController _emailController = TextEditingController(
    text: "johndoe@example.com",
  );
  final TextEditingController _phoneController = TextEditingController(
    text: "+84 123 456 789",
  );
  final TextEditingController _addressController = TextEditingController(
    text: "Hà Nội, Việt Nam",
  );

  bool _isEditing = false; // chế độ xem / chỉnh sửa

  // Controller cho Animation
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeadBar(title: "Profile"),
      drawer: const SideBar(),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: AuroraPainter(_controller.value),
                child: Container(),
              );
            },
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar
                Center(
                  child: Hero(
                    tag: "profileAvatar",
                    child: const CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage('images/support-ticket.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Tên & Email hiển thị ngắn gọn
                Text(
                  _nameController.text,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _emailController.text,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 30),

                // 🔹 Thông tin có thể chỉnh sửa
                _buildEditableField(
                  Icons.person,
                  "Tên người dùng",
                  _nameController,
                ),
                _buildEditableField(Icons.email, "Email", _emailController),
                _buildEditableField(
                  Icons.phone,
                  "Số điện thoại",
                  _phoneController,
                ),
                _buildEditableField(
                  Icons.location_on,
                  "Địa chỉ",
                  _addressController,
                ),

                const SizedBox(height: 30),

                // Nút hành động
                _isEditing
                    ? ElevatedButton.icon(
                        icon: const Icon(Icons.save),
                        label: const Text("Lưu thay đổi"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _isEditing = false;
                          });

                          // TODO: Gửi dữ liệu lên backend để update
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Thông tin cá nhân đã được cập nhật",
                              ),
                            ),
                          );
                        },
                      )
                    : ElevatedButton.icon(
                        icon: const Icon(Icons.edit),
                        label: const Text("Chỉnh sửa"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _isEditing = true;
                          });
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Hàm dựng một field thông tin
  Widget _buildEditableField(
    IconData icon,
    String label,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: _isEditing
                ? TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: label,
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.text,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

/// 🔹 Aurora Painter - vẽ bong bóng gradient di chuyển
class AuroraPainter extends CustomPainter {
  final double progress;
  AuroraPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..blendMode = BlendMode.srcOver;

    // 3 bong bóng aurora
    _drawAuroraBlob(
      canvas,
      size,
      paint,
      Colors.purpleAccent.withValues(alpha: 0.3),
      offset(progress, size, 100, 0.2),
      200,
    );
    _drawAuroraBlob(
      canvas,
      size,
      paint,
      Colors.blueAccent.withValues(alpha: 0.25),
      offset(progress, size, 150, 0.5),
      250,
    );
    _drawAuroraBlob(
      canvas,
      size,
      paint,
      Colors.tealAccent.withValues(alpha: 0.2),
      offset(progress, size, 200, 0.8),
      220,
    );
  }

  void _drawAuroraBlob(
    Canvas canvas,
    Size size,
    Paint paint,
    Color color,
    Offset center,
    double radius,
  ) {
    final Rect rect = Rect.fromCircle(center: center, radius: radius);
    paint.shader = RadialGradient(
      colors: [color, Colors.transparent],
    ).createShader(rect);
    canvas.drawCircle(center, radius, paint);
  }

  /// Tính vị trí bong bóng theo progress animation
  Offset offset(double progress, Size size, double radius, double speed) {
    final double dx =
        size.width / 2 +
        cos(progress * 2 * pi * speed) * (size.width / 3 - radius);
    final double dy =
        size.height / 2 +
        sin(progress * 2 * pi * speed) * (size.height / 3 - radius);
    return Offset(dx, dy);
  }

  @override
  bool shouldRepaint(AuroraPainter oldDelegate) => true;
}
