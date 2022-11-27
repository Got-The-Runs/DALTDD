class LinhVucObject {
  final int idLinhVuc;
  final String tenLinhVuc;
  final int trangThai;

  LinhVucObject(
       this.idLinhVuc,
       this.tenLinhVuc,
       this.trangThai
  );

   LinhVucObject.fromJson(Map<String, dynamic> json) 
      :idLinhVuc= json['id_linh_vuc'],
       tenLinhVuc= json['ten_linh_vuc'],
       trangThai= json['trang_thai'];

   Map<String, Object?> toJson() {
    return {
      'id_linh_vuc': idLinhVuc,
      'ten_linh_vuc': tenLinhVuc,
      'trang_thai': trangThai,
    };
  }
}
