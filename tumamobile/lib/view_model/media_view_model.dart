
import 'package:flutter/cupertino.dart';
import 'package:tumamobile/model/media.dart';
import 'package:tumamobile/service/media_service.dart';
import 'package:tumamobile/utils/api_response.dart';

class MediaViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty Data');

  Media? _media;

  ApiResponse get response {
    return _apiResponse;
  }

  Media? get media {
    return _media;
  }

  Future<void> fetchMediaData(String query) async {
    _apiResponse = ApiResponse.loading("Fetching artist data");
    notifyListeners();
    try {
      List<Media> mediaList = await MediaService().fetchMediaList(query);
      _apiResponse = ApiResponse.completed(mediaList);
    } catch(ex) {
      print(ex);
      _apiResponse = ApiResponse.error(ex.toString());
    }
    notifyListeners();
  }

  void setSelectedMedia(Media? media) {
    _media = media;
    notifyListeners();
  }
}