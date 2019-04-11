import 'dart:math';

import 'package:com.hzztai.mdt/common/services/config.dart';
import 'package:com.hzztai.mdt/common/services/http_service.dart';
import 'package:com.hzztai.mdt/common/services/kfb/kfb_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class KFBView extends StatelessWidget {
  final String filePath;

  KFBView(this.filePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<HttpFinalResult<KFBInfo>>(
        future: KFBService.getInfo(filePath),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error.isEmpty) {
              final kfbInfo = snapshot.data.data;
              return FlutterMap(
                options: new MapOptions(
                  center: new LatLng(0, 0),
                  zoom: 0.0,
                  maxZoom: kfbInfo.fileNum - log(kfbInfo.imageBlockLen) / ln2,
                  minZoom: 0),
                layers: [
                  new TileLayerOptions(
                    kfbInfo: kfbInfo,
                    urlTemplate: "$apiHost/image.php?file=${Uri.encodeComponent(filePath)}")
                ],
              );
            } else {
              return Center(
                child: Text('出错了'),
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
    );
  }
}
