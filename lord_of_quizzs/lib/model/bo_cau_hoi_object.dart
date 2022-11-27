class BoCauHoiObject {
  final int idBoCauHoi;
  final int idLinhVuc;
  final int trangThai;

  BoCauHoiObject(
       this.idBoCauHoi,
       this.idLinhVuc,
       this.trangThai
  );

   BoCauHoiObject.fromJson(Map<String, dynamic> json) 
      :idBoCauHoi= json['id_bo_cau_hoi'],
       idLinhVuc= json['id_linh_vuc'],    
       trangThai= json['trang_thai'];

   Map<String, Object?> toJson() {
    return {
      'id_bo_cau_hoi': idBoCauHoi,
      'id_linh_vuc': idLinhVuc,
      'trang_thai': trangThai,
    };
  }
}
