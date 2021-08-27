class DriverApi {
  static String baseUrL = "http://admin.getsmartride.com"; // global
  // static String baseUrL = "http://182.176.112.99:35055"; // global
  // static String baseUrL = "http://192.168.10.90:35055"; // local

  //1

  static String driverLogin =
      "${DriverApi.baseUrL}/api/Driver/PublicDriverLogin";

  //2

  static String driverSignUP =
      "${DriverApi.baseUrL}/api/Driver/PublicSignUpDriver";

  //3
  static String driverCNICUpload =
      "${DriverApi.baseUrL}/Home/PublicUploadDriverCNICPic";
  //4
  static String drivingLicenceUpload =
      "${DriverApi.baseUrL}/Home/PublicUploadDrivingLicenceImage";

  //5
  static String driverImageUpload =
      "${DriverApi.baseUrL}/Home/PublicUploadDriverImage";

  //6
  static String driverVehicleInfo =
      "${DriverApi.baseUrL}/api/Driver/PublicInsertVehicleInfo";

  //7
  static String driverVehicleType =
      "${DriverApi.baseUrL}/api/Driver/PublicVehicleTypesByDriverData";

  //8
  static String driverLatestBookingRequestById =
      "${DriverApi.baseUrL}/api/RidingClient/PublicGetRidingRequestDataById";

  //9
  static String getAllRidingRequestsForDriver =
      "${DriverApi.baseUrL}/api/Driver/PublicGetMyRidingRequestsForDriver";

  //10
  static String getPenaltyTimeAndAmountForDriver =
      "${DriverApi.baseUrL}/api/Driver/PublicGetPenaltyTimeAndAmountForDriver";

  //11

  static String getFranschiseData =
      "${DriverApi.baseUrL}/api/Driver/PublicGetDriverFranchiseData";

  //12
  static String getDriverRideBill =
      "${DriverApi.baseUrL}/api/Driver/PublicGetRideBill";

  //13
  static String getDriverTodayEarning =
      "${DriverApi.baseUrL}/api/Driver/PUblicGetTodayEarnings";

  //14
  static String getDriverFromToDayEarning =
      "${DriverApi.baseUrL}/api/Driver/PUblicGetFromToDayEarnings";

  //15
  static String getDriverProfile =
      "${DriverApi.baseUrL}/api/Driver/PublicGetDriversProfile";

  //16
  static String updateDriverProfile =
      "${DriverApi.baseUrL}/api/Driver/PublicUpdateDriverData";

  //17
  static String driverLoginWithMobileAfterOTPVerify =
      "${DriverApi.baseUrL}/api/Driver/PublicDriverLoginWithMobileAfterOTPVerify";
}
//
