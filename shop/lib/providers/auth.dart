import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';

class AuthState {
  String? token;
  DateTime? expiryDate;
  String? uid;

  AuthState({
    this.token,
    this.expiryDate,
    this.uid,
  });

  bool get isSignedIn {
    if (expiryDate != null &&
        expiryDate!.isAfter(DateTime.now()) &&
        token != null) {
      return true;
    }
    return false;
  }
}

class Auth extends StateNotifier<AuthState> {
  Auth(AuthState state) : super(state);

  Future<void> singup(String email, String password) async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBNX8_H_tNAzsBlIb2Hc5zI95BrgBC0UM0');
    Response res = await post(url,
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));

    Map resData = json.decode(res.body);
    state = AuthState(
        token: resData['idToken'],
        uid: resData['localId'],
        expiryDate: DateTime.now()
            .add(Duration(seconds: int.parse(resData['expiresIn']))));
  }

  Future<void> signin(String email, String password) async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBNX8_H_tNAzsBlIb2Hc5zI95BrgBC0UM0');
    Response res = await post(url,
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
    Map resData = json.decode(res.body);
    print(resData);
    state = AuthState(
        token: resData['idToken'],
        uid: resData['localId'],
        expiryDate: DateTime.now()
            .add(Duration(seconds: int.parse(resData['expiresIn']))));
  }
}

final authProvider =
    StateNotifierProvider<Auth, AuthState>((_) => Auth(AuthState()));
