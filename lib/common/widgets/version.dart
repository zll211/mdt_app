import 'package:package_info/package_info.dart';
import 'package:flutter/material.dart';

class Version extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:  PackageInfo.fromPlatform(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Text('v${snapshot.data.version}(${snapshot.data.buildNumber})',style: TextStyle(color:Color(0xFFA2A7AF)),);
        }
        return Text('');
      },
    );
  }
}



