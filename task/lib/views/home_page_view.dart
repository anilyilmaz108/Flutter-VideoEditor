import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/components/floating_button_widget.dart';
import 'package:task/components/image_items.dart';
import 'package:task/components/my_icon_button.dart';
import 'package:task/constants.dart';
import 'package:task/services/home_provider.dart';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kAppTitle),
      ),
      floatingActionButton: FloatingButtonWidget(
        child: Icon(Icons.play_arrow),
        onClicked: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.amber,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            MyIconButton(icon: Icons.settings_backup_restore, onPressed: (){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
            },),
            MyIconButton(icon: Provider.of<HomeProvider>(context).isClean ? Icons.cancel : Icons.edit, onPressed: (){
              Provider.of<HomeProvider>(context, listen: false).combinedFunction();
            },),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.zero,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Container()
            ),
            Expanded(
              flex: 1,
              child: GridView.extent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1.0,
                  padding: const EdgeInsets.all(4),
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  children: Provider.of<HomeProvider>(context).images.length > 0
                      ? Provider.of<HomeProvider>(context).images
                      .map((image) {
                        return ImageItem(image: image);
                  })
                      .toList()
                      : [Container(color: Colors.white,)]),
            ),
          ],
        ),
      ),
    );
  }





}