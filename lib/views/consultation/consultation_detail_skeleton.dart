import 'package:com.hzztai.mdt/common/theme/theme.dart';
import 'package:flutter/material.dart';

class ConsultationDetailSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final greyColor = Color(0xFFF5F5F5);
    final normalHeight = 20.0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(normalPadding),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 60.0, bottom: 20.0),
                      padding: EdgeInsets.all(normalPadding),
                      decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.all(const Radius.circular(8.0)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: normalPadding,
                                height: 20.0,
                                margin: EdgeInsets.only(right: normalPadding/2),
                                color: greyColor,
                              ),
                              Container(
                                width: normalHeight*3,
                                height: normalHeight,
                                color: greyColor,
                              ),

                            ],
                          ),
                          SizedBox(height: normalPadding,),
                          Row(
                            children: <Widget>[
                              Container(
                                width: normalPadding,
                                height: normalHeight,
                                margin: EdgeInsets.only(right: normalPadding/2),
                                color: greyColor,
                              ),
                              Container(
                                width: normalHeight*8,
                                height: normalHeight,
                                color: greyColor,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(normalPadding),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: normalHeight*3,
                          height: normalHeight,
                          margin: EdgeInsets.only(right: normalPadding),
                          color: greyColor,
                        ),
                        Container(
                          width: normalHeight*10,
                          height: normalHeight,
                          color: greyColor,
                        ),

                      ],
                    ),
                    SizedBox(height: normalPadding,),
                    Row(
                      children: <Widget>[
                        Container(
                          width: normalHeight*3,
                          height: normalHeight,
                          margin: EdgeInsets.only(right: normalPadding),
                          color: greyColor,
                        ),
                        Container(
                          width: normalHeight*6,
                          height: normalHeight,
                          color: greyColor,
                        ),

                      ],
                    ),
                    SizedBox(height: normalPadding,),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50.0,
                          height: normalHeight,
                          margin: EdgeInsets.only(right: normalPadding),
                          color: greyColor,
                        ),
                        SizedBox(width: normalHeight/2),
                        Container(
                          width: normalHeight*3,
                          height: normalHeight,
                          color: greyColor,
                        ),

                      ],
                    ),
                    SizedBox(height: normalPadding,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: normalHeight*3,
                          height: normalHeight,
                          margin: EdgeInsets.only(right: normalPadding),
                          color: greyColor,
                        ),
                        Expanded(
                          child: Container(
                            height: normalHeight*2,
                            color: greyColor,
                          )
                        ),
                      ],
                    ),
                    SizedBox(height: normalPadding,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: normalHeight*2,
                          height: normalHeight,
                          margin: EdgeInsets.only(right: normalPadding),
                          color: greyColor,
                        ),
                        SizedBox(width: normalHeight,),
                        Expanded(
                            child: Container(
                              height: normalHeight*2,
                              color: greyColor,
                            )
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(normalPadding,normalHeight,normalPadding,normalHeight),
                margin: EdgeInsets.only(top: normalPadding,bottom: normalPadding),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: normalHeight*3,
                      height: normalHeight,
                      color: greyColor,
                    ),
                    Container(
                      width: 10.0,
                      height: normalPadding,
                      color: greyColor,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(normalPadding,normalHeight,normalPadding,normalHeight),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: normalHeight*3,
                      height: normalHeight,
                      color: greyColor,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width:30.0,
                          height: 30.0,
                          margin: EdgeInsets.only(right: normalPadding/4),
                          decoration: BoxDecoration(
                            color: greyColor,
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          ),
                        ),
                        Container(
                          width:30.0,
                          height: 30.0,
                          margin: EdgeInsets.only(right: normalPadding/4),
                          decoration: BoxDecoration(
                            color: greyColor,
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          ),
                        ),
                        Container(
                          width:30.0,
                          height: 30.0,
                          margin: EdgeInsets.only(right: normalPadding/2),
                          decoration: BoxDecoration(
                            color: greyColor,
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          ),
                        ),
                        Container(
                          width: 10.0,
                          height: normalPadding,
                          color: greyColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
