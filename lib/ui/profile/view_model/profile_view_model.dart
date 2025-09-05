import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/data/dto/user_dto.dart';
import 'package:ticket_helpdesk/domain/usecases/user_usecases.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserUseCases _userUsecase;

  ProfileViewModel({required UserUseCases userUsecase})
    : _userUsecase = userUsecase {
    loadInitialData();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  bool _isEditing = false;
  bool get isEditing => _isEditing;

  late UserDto user;
  bool loadingUsers = true;
  String? errorMessage;

  Future<void> loadInitialData() async {
    try {
      user = await _userUsecase.fetchMyUser();
      print(user.fullName);
      nameController.text = user.fullName;
      emailController.text = user.email;
      phoneController.text = user.phone ?? "0";
      dobController.text = user.dob as String;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      loadingUsers = false;
      notifyListeners();
    }
  }

  void toggleEdit() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  void saveChanges() {
    _isEditing = false;
    notifyListeners();
  }

  void disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
  }
}
