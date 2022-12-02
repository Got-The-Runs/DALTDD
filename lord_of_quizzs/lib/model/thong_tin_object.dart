class ThongTinObject {
  final String name;
  final String email;
  final num money;
  final int trangthai;

  ThongTinObject( this.name, this.email, this.money,
      this.trangthai);

  ThongTinObject.fromJson(Map<String, dynamic> json)
      : name = json['ten_nguoi_choi'],
        email = json['email'],
        money = json['tien_ao'],
        trangthai = json['trang_thai'];

  Map<String, Object?> toJson() {
    return {
      'ten_nguoi_choi': name,
      'email': email,
      'money': money,
      'trang_thai': trangthai,
    };
  }
}
