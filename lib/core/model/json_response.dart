class JsonResponse {
  late String clientPassword;
  late String adminPassword;
  late String timer;
  late String ssid;
  late String Comp_Name;

  JsonResponse(
      {required this.clientPassword,
      required this.adminPassword,
      required this.timer,
      required this.ssid,
     required this.Comp_Name,
      });

  JsonResponse.fromJson(Map<String, dynamic> json) {
    clientPassword = json['client_password'];
    adminPassword = json['admin_password'];
    timer = json['timer'];
    ssid = json['ssid'];
    Comp_Name = json['Comp_Name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_password'] = this.clientPassword;
    data['admin_password'] = this.adminPassword;
    data['timer'] = this.timer;
    data['ssid'] = this.ssid;
    data['Comp_Name'] = this.Comp_Name;

    return data;
  }
}
