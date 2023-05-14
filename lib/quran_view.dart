import 'package:flutter/material.dart';

class QuranView extends StatefulWidget {
  const QuranView({Key? key}) : super(key: key);

  @override
  State<QuranView> createState() => _QuranViewState();
}

class _QuranViewState extends State<QuranView> {
  List ayah = [
    "lorem cvvsdfsv v end.",
    "lorem cvvsdfsv v sdfvf ."
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Quran View"),
      ),
      body: Padding(padding: EdgeInsets.all(30),
      child:  Container(
        width: 300,
        child: Row(

          children: [
            for(int i=0;i<ayah.length;++i)
              Text(ayah[i]
                ,style: TextStyle(fontSize: 24),)

          ],

        ),
      )
      ),
    );
  }
}
