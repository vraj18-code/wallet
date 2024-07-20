import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LoggedOut());
            },
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              var userData = snapshot.data!.data() as Map<String, dynamic>;
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userData['photoURL']),
                      radius: 50,
                    ),
                    Text("Name: ${userData['name']}"),
                    Text("Email: ${userData['email']}"),
                  ],
                ),
              );
            } else {
              return Center(child: Text("No data available"));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
