import 'package:get/get.dart';
import 'package:get_smart_ride_cas/chat/models/message_model.dart';

class ChatController extends GetxController {
  Message message;

  static ChatController get to => Get.find<ChatController>();
  List<Message> messagesList = List<Message>();

  // recievedMsg(Message msg) {// ye method kahin hora use?mara khail sa use ni ho rha
  //   message = msg;
  //   print("Msg from Controller================= :$msg");
  //   update();
  // }

  sendMsg(Message msg) {
    message = msg;
    print("Msg from Controller================= :$msg");
    messagesList.add(message);
    messagesList.reversed;
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
