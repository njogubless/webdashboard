import 'dart:convert';

class Client {
  final String? uid;
  final String clientName;
  final String clientEmail;
  final String role;
  String? status;
  Client({
    required this.uid,
    required this.clientName,
    required this.clientEmail,
    required this.role,
    this.status = 'Pending',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'clientName': clientName,
      'clientEmail': clientEmail,
      'role': role,
      'status': status,
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      uid: map['uid'] != null ? map['uid'] as String : null,
      clientName: map['clientName'] as String,
      clientEmail: map['clientEmail'] as String,
      role: map['role'] as String,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Client.fromJson(Map<String, dynamic> map) {
    return Client(
      uid: map['uid'] != null ? map['uid'] as String : null,
      clientName: map['clientName'] as String,
      clientEmail: map['clientEmail'] as String,
      role: map['role'] as String,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }
}
