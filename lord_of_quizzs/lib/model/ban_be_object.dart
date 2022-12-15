class BanBeObject {
 final String email;
 final String emailBanBe;
 final int trangThai;
  BanBeObject(
       this.email,
       this.emailBanBe,
       this.trangThai,
  );

   BanBeObject.fromJson(Map<String, dynamic> json) 
      :email = json['email'],
       emailBanBe = json['email_ban_be'],    
       trangThai = json['trang_thai'];

   Map<String, Object?> toJson() {
    return {
      'email': email,
      'email_ban_be': emailBanBe,
      'trang_thai': trangThai,
    };
  }
}
