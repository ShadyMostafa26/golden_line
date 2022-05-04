



class AppUrl {
  static const String baseURL = "http://192.168.1.6/Ecommerce/public/api";
  static const String ApiUrlAuth = baseURL + "/auth";
  static const String login = ApiUrlAuth + "/login";
  static const String register = ApiUrlAuth + "/register";
  static const String refreshToken = ApiUrlAuth + "/refresh";
  static const String logout = ApiUrlAuth + "/logout";
  static const String userProfile = ApiUrlAuth + "/user-profile";





  //images links
  static const String ImageBaseLink = baseURL + "/images";
  static const String DoctorImageLink = ImageBaseLink + "/Doctor Images/";



  static const String ResultsLink = baseURL + "/Results/";

}
