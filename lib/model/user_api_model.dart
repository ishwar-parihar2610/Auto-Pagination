// ignore_for_file: public_member_api_docs, sort_constructors_first
class UsersListApiModel {
  bool? success;
  String? message;
  int? totalUsers;
  int? offset;
  int? limit;
  List<Users> users = [];

  UsersListApiModel(
      {this.success,
      this.message,
      this.totalUsers,
      this.offset,
      this.limit,
      this.users = const []});

  UsersListApiModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    totalUsers = json['total_users'];
    offset = json['offset'];
    limit = json['limit'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users.add(Users.fromJson(v));
      });
    }
  }

  UsersListApiModel copyWith({
    bool? success,
    String? message,
    int? totalUsers,
    int? offset,
    int? limit,
    List<Users>? users,
  }) {
    return UsersListApiModel(
      success: success ?? this.success,
      message: message ?? this.message,
      totalUsers: totalUsers ?? this.totalUsers,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      users: users ?? this.users,
    );
  }
}

class Users {
  int? id;
  String? gender;
  String? dateOfBirth;
  String? job;
  String? city;
  String? zipcode;
  double? latitude;
  String? profilePicture;
  String? firstName;
  String? email;
  String? lastName;
  String? phone;
  String? street;
  String? state;
  String? country;
  double? longitude;

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    job = json['job'];
    city = json['city'];
    zipcode = json['zipcode'];
    latitude = json['latitude'];
    profilePicture = json['profile_picture'];
    firstName = json['first_name'];
    email = json['email'];
    lastName = json['last_name'];
    phone = json['phone'];
    street = json['street'];
    state = json['state'];
    country = json['country'];
    longitude = json['longitude'];
  }
}
