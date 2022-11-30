class CauHoiObject {
  final int idCauHoi;
  final String cauHoi;
  final String cauTraLoi1;
  final String cauTraLoi2;
  final String cauTraLoi3;
  final String cauTraLoi4;
  final int dapAn;

  CauHoiObject(
       this.idCauHoi,
       this.cauHoi,
       this.cauTraLoi1,
       this.cauTraLoi2,
       this.cauTraLoi3,
       this.cauTraLoi4,
       this.dapAn
  );

   CauHoiObject.fromJson(Map<String, dynamic> json) 
      :idCauHoi = json['id_cau_hoi'],
       cauHoi = json['cau_hoi'],    
       cauTraLoi1 = json['cau_tra_loi_1'],
       cauTraLoi2 = json['cau_tra_loi_2'],
       cauTraLoi3 = json['cau_tra_loi_3'],
       cauTraLoi4 = json['cau_tra_loi_4'],
       dapAn = json['dap_an'];

   Map<String, Object?> toJson() {
    return {
      'id_cau_hoi': idCauHoi,
      'cau_hoi': cauHoi,
      'cau_tra_loi_': cauTraLoi1,
      'cau_tra_loi_2': cauTraLoi2,
      'cau_tra_loi_3' : cauTraLoi3,
      'cau_tra_loi_4' :cauTraLoi4,
      'dap_an' : dapAn
    };
  }
}
