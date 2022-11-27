class CTBoCauHoiObject {
  final int idBoCauHoi;
  final int idCauHoi;
  final int stt;

  CTBoCauHoiObject(
       this.idBoCauHoi,
       this.idCauHoi,
       this.stt
  );

   CTBoCauHoiObject.fromJson(Map<String, dynamic> json) 
      :idBoCauHoi= json['id_bo_cau_hoi'],
       idCauHoi= json['id_cau_hoi'],    
       stt= json['stt'];

   Map<String, Object?> toJson() {
    return {
      'id_bo_cau_hoi': idBoCauHoi,
      'id_cau_hoi': idCauHoi,
      'stt': stt,
    };
  }
}
