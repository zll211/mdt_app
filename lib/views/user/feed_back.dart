import 'package:flutter/material.dart';
import 'package:com.hzztai.mdt/common/fonts/custom_icons.dart';
import './progress_dialog.dart';
import './pop_route.dart';
import './animate_hint.dart';
import 'package:image_picker/image_picker.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  var _imageFile;
  bool _loading  = false;
  List fileList = List();
  Set fileSet = Set();
  @override
  Widget build(BuildContext context) {
    return ProgressDialog(
      loading:_loading,
      child: Scaffold(
        appBar: AppBar(
          title:Text('意见反馈',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 19.0)),
          centerTitle: true,
          leading: InkWell(
            child:Center(child:Icon(CustomIcons.arrow_left,size:24.0)),
            onTap: (){
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[

            InkWell(
              child:Center(child:Text('确定',style:TextStyle(fontSize: 18.0,color:Colors.white,))),
              onTap: () async{
                setState(() {
                  _loading = true;
                });
                 Future.delayed(Duration(milliseconds: 500),(){
                  if(!mounted) return;
                  setState(() {
                    _loading = false;
                  });
                  Navigator.of(context).push(PopRoute(
                      child:AnimateHint(text:'保存成功',top:230.0)));
                });
//                Navigator.of(context).pop();
              },
            ),
            SizedBox(width: 10.0,),
          ],
        ),
        body: FutureBuilder(
          future: _imageFile,
          builder: (context, snapshot){
            if(snapshot.hasData){
              var length1 = fileSet.length;
              print(length1);
              print(snapshot.data);
              fileSet.add(snapshot.data);
              print(fileSet);
              if(fileSet.length>length1){
                fileList.add(snapshot.data);
              }
            }
            return getBody();
          },
        )
      ),
    );
  }

  getBody(){
    var textField = TextField(
          maxLines:6,
          maxLength: 200,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '简要描述你要反馈的问题和意见',
            hintStyle:TextStyle(color:Color(0xFFA2A7AF)),
          ),
    );
    var gridView = GridView.count(
        crossAxisCount: 4,
        children: new List.generate(
            fileList.length+1, (index){
              var content;
              if(index==fileList.length){
                var addCell = Container(
                  child: Icon(Icons.add),
                );
                content = GestureDetector(
                  child: addCell,
                  onTap: (){
                    pickImage();
                  },
                );
              } else {
                content = Center(
                  child:Image.file(fileList[index],width:80.0,height:80.0,fit:BoxFit.cover),
                );
              }
              return Container(
                margin: const EdgeInsets.all(2.0),
                width:80.0,
                height:80.0,
                color:Color(0xFFECECEC),
                child: content,
              );
            }
        )

    );

    return Container(
      padding:EdgeInsets.symmetric(horizontal: 12.0),
      child: ListView(
        children: <Widget>[
          DecoratedBox(
            child:textField,
            decoration: BoxDecoration(
              border: Border(bottom:BorderSide(color:Color(0xFFE2E6ED),width:1.0,))
            ),
          ),
        Container(
          margin:EdgeInsets.only(top:40.0),
          height:200.0,
          child: gridView,
        )
        ],
      ),
    );
  }
  pickImage(){
    return showDialog(context: context,builder: (context){
      return SimpleDialog(
        shape: const RoundedRectangleBorder(
            side:BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        children: <Widget>[
          _dialogMenuItem("相机拍照", source:ImageSource.camera,position:'top',isImage:true),
          new Divider(height: 2.0,),
          _dialogMenuItem("从手机相册选择", source:ImageSource.gallery,position: 'bottom',isImage:true)
        ],
      );
    });
  }
  _dialogMenuItem(title, {ImageSource source,String position='',bool isImage=false}) {
    var item = new Container(
      padding: position.length>0 ? position=='top'? EdgeInsets.only(bottom:7.0) :EdgeInsets.only(top:7.0) : null,
      height:32.0,
      child: new Center(
          child: new Text(title)
      ),
    );
    return new GestureDetector(
      child: item,
      onTap: () {
         Navigator.of(context).pop();
         setState(() {
           _imageFile = ImagePicker.pickImage(source: source);
         });
      },
    );
  }

}

//Container(
//
//decoration: BoxDecoration(
//color:Colors.white,
//border:Border(
//bottom: BorderSide(width:1.0,color:const Color(0xFFE2E6ED))
//)
//),
//padding:EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//child: TextField(
//maxLines:8,
//maxLength: 200,
//decoration: InputDecoration(
//border: InputBorder.none,
//hintText: '简要描述你要反馈的问题和意见',
//hintStyle:TextStyle(color:Color(0xFFA2A7AF)),
//),
//),
//),

