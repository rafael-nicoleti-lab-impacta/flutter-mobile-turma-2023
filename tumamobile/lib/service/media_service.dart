

import 'package:tumamobile/model/media.dart';
import 'package:tumamobile/service/service.dart';
import 'base_service.dart';


class MediaService {
  BaseService _service = Service();

  Future<List<Media>> fetchMediaList(String query) async {
    dynamic response = await _service.getResponse(query);
    final jsonData = response['results'] as List;
    List<Media> mediaList = jsonData.map((tagJson) => Media.fromJson(tagJson)).toList();

    return mediaList;
  }
}