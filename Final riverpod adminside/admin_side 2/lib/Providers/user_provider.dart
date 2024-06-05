import 'package:admin_side/Services/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import 'package:admin_side/Services/user_service.dart';

class UserListState {
  final bool isLoading;
  final List<User> users;
  final String error;

  UserListState({
    required this.isLoading,
    required this.users,
    required this.error,
  });

  UserListState copyWith({
    bool? isLoading,
    List<User>? users,
    String? error,
  }) {
    return UserListState(
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
      error: error ?? this.error,
    );
  }
}

class UserListNotifier extends StateNotifier<UserListState> {
  final UserService userService;

  UserListNotifier({required this.userService})
      : super(UserListState(isLoading: false, users: [], error: ''));

  Future<void> fetchUsers(String accessToken) async {
    state = state.copyWith(isLoading: true);

    try {
      final users = await userService.fetchUsers(accessToken);
      state = state.copyWith(
        users: users,
        isLoading: false,
        error: '',
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        error: 'An error occurred. Please try again later.',
      );
    }
  }

  Future<void> updateUserRole(
      String accessToken, String email, String newRole) async {
    try {
      await userService.updateUserRole(accessToken, email, newRole);
      state = state.copyWith(
        users: state.users.map((user) {
          return user.email == email
              ? User(email: user.email, role: newRole)
              : user;
        }).toList(),
      );
    } catch (error) {
      state = state.copyWith(
        error: 'An error occurred. Please try again later.',
      );
    }
  }
}

final userServiceProvider = Provider((ref) => UserService());

final userListProvider =
    StateNotifierProvider<UserListNotifier, UserListState>((ref) {
  final userService = ref.watch(userServiceProvider);
  return UserListNotifier(userService: userService);
});
