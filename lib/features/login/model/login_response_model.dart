class LoginResponseModel {
  final String? status;
  final String? message;
  final LoginData? data;

  LoginResponseModel({this.status, this.message, this.data});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data?.toJson()};
  }
}

class LoginData {
  final String? userId;
  final int? id;
  final String? userName;
  final String? email;
  final String? token;
  final String? expiryDate;
  final AirlineAgent? airlineAgent;

  LoginData({
    this.userId,
    this.id,
    this.userName,
    this.email,
    this.token,
    this.expiryDate,
    this.airlineAgent,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      userId: json['userId'],
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      token: json['token'],
      expiryDate: json['expiryDate'],
      airlineAgent: json['airlineAgent'] != null
          ? AirlineAgent.fromJson(json['airlineAgent'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'userName': userName,
      'email': email,
      'token': token,
      'expiryDate': expiryDate,
      'airlineAgent': airlineAgent?.toJson(),
    };
  }
}

class AirlineAgent {
  final int? id;
  final String? nameAr;
  final String? nameAn;
  final String? phone1;
  final String? phone2;
  final String? email;
  final String? address;
  final int? airLineId;
  final String? userId;
  final bool? isActive;
  final dynamic airLine;

  AirlineAgent({
    this.id,
    this.nameAr,
    this.nameAn,
    this.phone1,
    this.phone2,
    this.email,
    this.address,
    this.airLineId,
    this.userId,
    this.isActive,
    this.airLine,
  });

  factory AirlineAgent.fromJson(Map<String, dynamic> json) {
    return AirlineAgent(
      id: json['id'],
      nameAr: json['nameAr'],
      nameAn: json['nameAn'],
      phone1: json['phone1'],
      phone2: json['phone2'],
      email: json['email'],
      address: json['address'],
      airLineId: json['airLineId'],
      userId: json['userId'],
      isActive: json['isActive'],
      airLine: json['airLine'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameAr': nameAr,
      'nameAn': nameAn,
      'phone1': phone1,
      'phone2': phone2,
      'email': email,
      'address': address,
      'airLineId': airLineId,
      'userId': userId,
      'isActive': isActive,
      'airLine': airLine,
    };
  }
}
