import 'package:com.hzztai.mdt/common/services/patient/attachment.dart';
import 'package:com.hzztai.mdt/common/theme/theme.dart';
import 'package:com.hzztai.mdt/common/widgets/kfb_view.dart';
import 'package:flutter/material.dart';

class FileList extends StatelessWidget {
  final List<Attachment> attachment;

  FileList(this.attachment);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('资源附件'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: attachment
              .map((i) => GestureDetector(
                    onTap: () {
                      if (i.type == AttachmentType.kfb) {
                        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                          builder: (context) => KFBView(i.path),
                          fullscreenDialog: true,
                        ));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: normalPadding),
                      padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFEAEAEA), width: 1))),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 40.0,
                            margin: EdgeInsets.only(right: normalPadding),
                            child: Image.asset(
                              _dataToType(i.type),
                            ),
                          ),
                          Text(i.fileName, style: TextStyle(height: 1.4, fontSize: 18.0)),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        )));
  }

  _dataToType(AttachmentType type) {
    switch (type) {
      case AttachmentType.ct:
        return 'lib/common/images/file/ct.png';
      case AttachmentType.mri:
        return 'lib/common/images/file/mri.png';
      case AttachmentType.cr:
        return 'lib/common/images/file/cr.png';
      case AttachmentType.dr:
        return 'lib/common/images/file/dr.png';
      case AttachmentType.dsa:
        return 'lib/common/images/file/dsa.png';
      case AttachmentType.rf:
        return 'lib/common/images/file/rf.png';
      case AttachmentType.us:
        return 'lib/common/images/file/us.png';
      case AttachmentType.ultrasonic:
        return 'lib/common/images/file/ultrasonic.png';
      case AttachmentType.kfb:
        return 'lib/common/images/file/kfb.png';
      case AttachmentType.endoscopy:
        return 'lib/common/images/file/endoscopy.png';
      case AttachmentType.ecg:
        return 'lib/common/images/file/ecg.png';
      default:
        return 'lib/common/images/file/other.png';
    }
  }
}
