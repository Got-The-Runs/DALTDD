class CTBoCauHoiObject {
  final int idBoCauHoi;
  final int idCauHoi;

  CTBoCauHoiObject(
       this.idBoCauHoi,
       this.idCauHoi
  );

   CTBoCauHoiObject.fromJson(Map<String, dynamic> json) 
      :idBoCauHoi= json['id_bo_cau_hoi'],
       idCauHoi= json['id_cau_hoi'];   

   Map<String, Object?> toJson() {
    return {
      'id_bo_cau_hoi': idBoCauHoi,
      'id_cau_hoi': idCauHoi,
    };
  }
}
