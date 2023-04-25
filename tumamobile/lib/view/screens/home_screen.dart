
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumamobile/utils/api_response.dart';
import 'package:tumamobile/view/widgets/player_list_widget.dart';
import 'package:tumamobile/view/widgets/player_widget.dart';
import 'package:tumamobile/view_model/media_view_model.dart';

import '../../model/media.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final _iputController = TextEditingController();
    ApiResponse apiResponse = Provider.of<MediaViewModel>(context).response;

    return Scaffold(
      appBar: AppBar(
        title: Text("Media Player List"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor.withAlpha(50),
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black
                ),
                controller: _iputController,
                onChanged: (value){},
                onSubmitted: (value){
                  if(value.isNotEmpty) {
                    Provider.of<MediaViewModel>(context, listen: false)
                        .fetchMediaData(value);
                  }
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder:  InputBorder.none,
                  focusedBorder: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintText: "Pesquisa aqui"
                ),
              ),
            ),
          ),
          Expanded(child: getMediaWidget(context, apiResponse))
        ],
      ),
    );
  }

  Widget getMediaWidget(BuildContext context, ApiResponse apiResponse) {
    switch(apiResponse.status) {
      case Status.LOADING:
        return Center(child: CircularProgressIndicator(),);
      case Status.COMPLETED:
        List<Media>? mediaList = apiResponse.data as List<Media>?;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                flex: 8,
                child: PlayerListWidget(mediaList!, (Media media) {
                  Provider.of<MediaViewModel>(context, listen: false)
                      .setSelectedMedia(media);
                })
            ),
            Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: PlayerWidget(function: () {
                    setState(() {});
                  },),
                ))
          ],
        );
      case Status.ERROR:
        return Center(child: Text("Por favor tente novamente"),);
      case Status.INITIAL:
      default:
        return Center(child: Text('Pesquisa o nome da musica ou artista acima'),);
    }
  }
}