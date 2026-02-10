import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StreamProvider.autoDispose<AppUser?>((ref) async* {
  final Stream<AppUser?> userStream = FirebaseAuth.instance
      .authStateChanges()
      .map((user) {
        if (user != null) {
          return AppUser(uid: user.uid, email: user.email!);
        }
        return null;
      });

  await for (final user in userStream) {
    yield user;
  }

  // yield* userStream;
});
