import 'package:flutter/material.dart';

SliverAppBar homeappBar({required String username, required String greetings}) {
  return SliverAppBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
    ),
    
    
  ),
  centerTitle: true,
  title: Text('Daily Hub'),
  flexibleSpace: FlexibleSpaceBar(
    centerTitle: true,
    background: Align(
      alignment: AlignmentGeometry.topRight,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$greetings $username!',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    ),
  ),
  );
}