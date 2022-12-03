class NguoiChoiObject {
  final String email;
  final String tenNguoiChoi;
  final String ngayChoi;
  final int idLinhVuc;
  final int soCauDung;
  final num tongDiem; 

  NguoiChoiObject(this.email, this.tenNguoiChoi, this.ngayChoi, this.idLinhVuc, this.soCauDung, this.tongDiem);

  NguoiChoiObject.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        tenNguoiChoi = json['ten_nguoi_choi'],
        ngayChoi = json['ngay_choi'],
        idLinhVuc = json['id_linh_vuc'],
        soCauDung = json['so_cau_dung'],
        tongDiem = json['tong_diem'];

  Map<String, Object?> toJson() {
    return {
      'ten_nguoi_choi': tenNguoiChoi,
      'email': email,
      'ngay_choi': ngayChoi,
      'id_linh_vuc': idLinhVuc,
      'so_cau_dung': soCauDung,
      'tong_diem': tongDiem,
    };
  }
}
