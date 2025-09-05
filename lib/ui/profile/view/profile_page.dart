import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_helpdesk/config/service_locator.dart';
import 'package:ticket_helpdesk/ui/core/widgets/head_bar.dart';
import 'package:ticket_helpdesk/ui/core/widgets/side_bar.dart';
import 'package:ticket_helpdesk/ui/profile/view_model/profile_view_model.dart';
import 'package:ticket_helpdesk/ui/profile/widgets/editable_field.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(userUsecase: getIt()),
      child: Consumer<ProfileViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            appBar: const HeadBar(title: "Profile"),
            body: SingleChildScrollView(
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
                        backgroundImage: AssetImage('images/corpHubv2.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Tên & Email
                  Text(
                    vm.nameController.text,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    vm.emailController.text,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 30),

                  // Editable fields
                  EditableField(
                    icon: Icons.person,
                    label: "Tên người dùng",
                    controller: vm.nameController,
                    isEditing: vm.isEditing,
                  ),
                  EditableField(
                    icon: Icons.email,
                    label: "Email",
                    controller: vm.emailController,
                    isEditing: vm.isEditing,
                  ),
                  EditableField(
                    icon: Icons.phone,
                    label: "Số điện thoại",
                    controller: vm.phoneController,
                    isEditing: vm.isEditing,
                  ),
                  EditableField(
                    icon: Icons.location_on,
                    label: "Ngày Sinh",
                    controller: vm.dobController,
                    isEditing: vm.isEditing,
                  ),

                  const SizedBox(height: 30),

                  // Nút hành động
                  ElevatedButton.icon(
                    icon: Icon(vm.isEditing ? Icons.save : Icons.edit),
                    label: Text(vm.isEditing ? "Lưu thay đổi" : "Chỉnh sửa"),
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
                      if (vm.isEditing) {
                        vm.saveChanges();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Thông tin cá nhân đã được cập nhật"),
                          ),
                        );
                      } else {
                        vm.toggleEdit();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
