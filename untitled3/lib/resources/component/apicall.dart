
import 'package:dio/dio.dart';
class dioapi{
  final dio =Dio();
  void downloadFile(String address) async {
    await dio.download(
      '$address',
      '/storage/emulated/0/Download/downloaded_image.jpg',
      onReceiveProgress: (received, total) {
        print('Download progress: ${received / total * 100}%');
      },
    );
  }


}
