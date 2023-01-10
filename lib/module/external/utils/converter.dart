import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';

class AppConverter {
  imageToBase64() async {
    File imagefile = File("assets/image/logo.png");
    Uint8List imagebytes = await imagefile.readAsBytes();
    String base64string = base64.encode(imagebytes);

    return base64string;
  }

  base64ToBytes(String base64string) {
    Uint8List decodedbytes = base64.decode(base64string);

    return decodedbytes;
  }
}
