class RiderApi {
  // static String baseUrl = "http://192.168.10.90:35055";  // local

  // static String baseUrl = "http://182.176.112.99:35055"; // global
  static String baseUrl = "http://admin.getsmartride.com"; // global

 //static String baseUrl = "http://gsr.eshelf.ca"; // global

  //
  static String insertRiderEmail =
      "$baseUrl/api/RidingClient/PublicCheckClientByEmail";

  // 2
  //

  static String insertRider =
      "$baseUrl/api/RidingClient/PublicInsertRidingClient";

  // 3
  //
  static String insertRidingClientPhoeNumber =
      "$baseUrl/api/RidingClient/PublicUpdateRidingClientPhoeNumber";

  // 4
  //
  static String getVehicleType =
      "$baseUrl/api/Driver/PublicVehicleTypesCityName";

  // 5
  //
  static String getDistanceCostVehicleVise =
      "$baseUrl/api/RidingClient/PublicGetDistanceCostVechicleVise";

  // 6
  //
  static String getCityId = "$baseUrl/api/Driver/PublicGetCityIdByCityName";

  // 6
  //
  static String getAllRidingListForRider =
      "$baseUrl/api/RidingClient/PublicGetMyRidingRequestsForClient";

  //7
  //
  static String getPenaltyForRider =
      "$baseUrl/api/RidingClient/PublicGetPenaltyTimeAndAmountForClient";

  static String getDriverData = "$baseUrl/api/Driver/PublicGetDriverDataById";

  static String getPenaltyTimeAndAmountForClient =
      "$baseUrl/api/RidingClient/PublicGetPenaltyTimeAndAmountForClient";

  static String publicGetRideBill = "$baseUrl/api/Driver/PublicGetRideBill";

  ///
  static String riderImageUpload =
      "$baseUrl/Home/PublicUploadRidingClientImage";

  //
  static String loginClientPhoneNo =
      "$baseUrl/api/RidingClient/PublicLoginClientbyPhoneNumberAfterOTPVerify";
}
