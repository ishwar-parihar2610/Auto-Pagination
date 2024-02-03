import 'dart:convert';

import 'package:common_paggination_package/model/user_api_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

ValueNotifier<UsersListApiModel?> userListNotifier = ValueNotifier(null);

getUserDetails(int pageIndex, {bool init = false}) async {
  if (init) {
    userListNotifier.value = null;
    userListNotifier.notifyListeners();
  }

  String url =
      'https://api.slingacademy.com/v1/sample-data/users?offset=$pageIndex&limit=10';

  print("api url is $url");
  await http.get(Uri.parse(url)).then((value) {
    print("value is >>> ${value.body}");

    if (value.statusCode == 200) {
      UsersListApiModel usersListApiModel =
          UsersListApiModel.fromJson(jsonDecode(value.body));
      if (userListNotifier.value == null) {
        userListNotifier.value = usersListApiModel;
      } else {
        List<Users> oldList = userListNotifier.value?.users ?? [];
        List<Users> newList = usersListApiModel.users ?? [];
        UsersListApiModel userModel = UsersListApiModel(
            offset: usersListApiModel.offset, users: [...oldList, ...newList]);
        userListNotifier.value = userModel;
      }

      userListNotifier.notifyListeners();
    }
  });
}
