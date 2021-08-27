import 'package:get/get.dart';
import 'package:get_smart_ride_cas/chat/models/message_model.dart';

class DriverChatController extends GetxController {
  Message message;
  static DriverChatController get to => Get.find<DriverChatController>();
  List<Message> messagesList = List<Message>();

  // recievedMsg(Message msg) {
  //   message = msg;

  //   update();
  // }

  sendMsg(Message msg) {
    message = msg;
    messagesList.add(message);
    update();
  }

  // @override
  // void onClose() {
  //   // called just before the Controller is deleted from memory
  //   messagesList.clear();
  //   super.onClose();
  // }
  listclear() {
    messagesList.clear();
  }
}
