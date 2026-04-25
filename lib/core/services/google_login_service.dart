// import 'dart:developer';

// import 'package:dartz/dartz.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:injectable/injectable.dart';
// import 'package:memo/core/errors/app_error.dart';
// import 'package:memo/features/auth/models/request/google_loign_request.dart';

// @injectable
// class GoogleLoginService {
//   GoogleLoginService();

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final _googleSignIn = GoogleSignIn.instance;

//   // initilizing the googleSigin in
//   Future<void> initilize() async {
//     try {
//       await _googleSignIn.initialize();
//     } catch (e) {
//       print(e.toString());
//       throw "Failed to initialize Google Sign In ${e.toString()}";
//     }
//   }

//   Future<Either<AppError, GoogleSignInRequest>> signInWithGoogle({
//     required String role,
//   }) async {
//     try {
//       await initilize();

//       final googleUser = await _googleSignIn.authenticate();

//       final userAuth = googleUser.authentication;
//       final crendital = GoogleAuthProvider.credential(
//         idToken: userAuth.idToken,
//       );

//       await _auth.signInWithCredential(crendital);

//       print("_auth.currentUser: ${_auth.currentUser}");
//       //TODO: fix here like the google login is not correct things are missing
//       return right(
//         GoogleSignInRequest(
//           name: googleUser.displayName ?? "",
//           email: googleUser.email,
//           idToken: await _auth.currentUser?.getIdToken() ?? "",
//         ),
//       );
//     } on FirebaseException {
//       print(
//         "FirebaseException: Failed to sign in with Google $FirebaseException",
//       );
//       return left(AppError.serverError(error: "Failed to sign in with Google"));
//     } catch (e) {
//       log(e.toString());
//       return left(AppError.serverError(error: e.toString()));
//     }
//   }
// }
