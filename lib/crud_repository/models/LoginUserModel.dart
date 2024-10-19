import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class UserHomeOrg extends Equatable {
  final String? username;
  final String? userid;
  final String? orgname;
  final String? orgid;
  final String? role;
  final String? userroleinorg;
  final String? useridinorg;
  final String? parentorg;

  const UserHomeOrg({
    this.username,
    this.userid,
    this.orgname,
    this.orgid,
    this.role,
    this.userroleinorg,
    this.useridinorg,
    this.parentorg,
  });

  factory UserHomeOrg.fromJson(Map<String, dynamic> json) {
    return UserHomeOrg(
      username: json['username'],
      userid: json['userId'],
      orgname: json['orgName'],
      orgid: json['orgId'],
      role: json['role'],
      userroleinorg: json['userRoleInOrg'],
      useridinorg: json['userIdInOrg'],
      parentorg: json['parentOrg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'userid': userid,
      'orgname': orgname,
      'orgid': orgid,
      'role': role,
      'user_role_in_Org': userroleinorg,
      'userIdInOrg': useridinorg,
      'parentOrg': parentorg,
    };
  }

  @override
  List<Object?> get props => [
        username,
        userid,
        orgname,
        orgid,
        role,
        userroleinorg,
        useridinorg,
        parentorg
      ];
}

@immutable
class LoginUser extends Equatable {
  final UserHomeOrg? userHomeOrg;
  final bool? isLoggedIn;

  const LoginUser({
    this.userHomeOrg,
    this.isLoggedIn,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) {
    return LoginUser(
      userHomeOrg: UserHomeOrg.fromJson(json),
      isLoggedIn: json['isLoggedIn'],
    );
  }

  Map<String, dynamic> toJson() {
    final json = userHomeOrg?.toJson() ?? {};
    json['isLoggedIn'] = isLoggedIn;
    return json;
  }

  // Getters for properties in UserHomeOrg
  String? get username => userHomeOrg?.username;
  String? get userid => userHomeOrg?.userid;
  String? get orgname => userHomeOrg?.orgname;
  String? get orgid => userHomeOrg?.orgid;
  String? get role => userHomeOrg?.role;
  String? get userroleinorg => userHomeOrg?.userroleinorg;
  String? get useridinorg => userHomeOrg?.useridinorg;
  String? get parentorg => userHomeOrg?.parentorg;

  @override
  List<Object?> get props => [userHomeOrg, isLoggedIn];
}
