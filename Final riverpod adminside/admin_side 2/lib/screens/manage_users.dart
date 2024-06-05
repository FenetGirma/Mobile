import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/user_provider.dart';

class ManageUsersScreen extends ConsumerStatefulWidget {
  final String accessToken;

  ManageUsersScreen({required this.accessToken});

  @override
  _ManageUsersScreenState createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends ConsumerState<ManageUsersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userListProvider.notifier).fetchUsers(widget.accessToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userListState = ref.watch(userListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Users'),
      ),
      body: userListState.isLoading
          ? Center(child: CircularProgressIndicator())
          : userListState.error.isNotEmpty
              ? Center(
                  child: Text(userListState.error,
                      style: TextStyle(color: Colors.red)))
              : ListView.builder(
                  itemCount: userListState.users.length,
                  itemBuilder: (context, index) {
                    final user = userListState.users[index];
                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        title: Text(user.email),
                        subtitle: Text('Role: ${user.role}'),
                        trailing: PopupMenuButton<String>(
                          onSelected: (newRole) {
                            ref.read(userListProvider.notifier).updateUserRole(
                                widget.accessToken, user.email, newRole);
                          },
                          itemBuilder: (context) => ['admin', 'user']
                              .map((role) => PopupMenuItem(
                                    value: role,
                                    child: Text(role),
                                  ))
                              .toList(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(user.role),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
