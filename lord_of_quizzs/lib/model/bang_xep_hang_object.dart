class BangXepHangObject {
  final String email;
  final int idLinhVuc;
  final num tongDiem;

  BangXepHangObject(this.email, this.idLinhVuc, this.tongDiem);

  BangXepHangObject.fromJson(Map<String, dynamic> json)
      : email = json['email'], 
        idLinhVuc = json['id_linh_vuc'],
        tongDiem = json['tong_diem'];

  Map<String, Object?> toJson() {
    return {
      'email': email,
      'id_linh_vuc': idLinhVuc,
      'tong_diem': tongDiem,
    };
  }
}
