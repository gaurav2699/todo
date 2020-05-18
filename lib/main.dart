import 'package:flutter/material.dart';


const String todoBoxName = "todo";

void main() async{

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      home: ListApp(),
    );
  }
}

class ListApp extends StatefulWidget {
  @override
  _ListAppState createState() => _ListAppState();
}

class _ListAppState extends State<ListApp> {
  TextEditingController ctrl= new TextEditingController();
  List<String> data = [];

  List<bool> checkbox=[];
  // todoBox=Hive.box<todoM>(todoBoxName);

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateTime(now.year, now.month, now.day);
    return Scaffold(
        appBar: AppBar(
          title: Text('${now.year}-${now.month}-${now.day}'),
          actions: <Widget>[
            new IconButton(
                icon:new Icon(Icons.remove),
                onPressed: (){
                  setState(() {
                    int counter=0;
                    while(counter < data.length){
                      if(checkbox[counter]==true){
                        checkbox.removeAt(counter);
                        data.removeAt(counter);
                        counter=0;
                      }
                      else{
                        counter++;
                      }
                    }
                  });
                }
            )
          ],
        ),
        body: buildList(),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('New Entry'),
                      content: new TextField (
                        controller: ctrl,
                        decoration: new InputDecoration.collapsed(hintText: 'Add your text here'),
                        maxLines: 3,
                        onSubmitted: (String text){

                        },
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('OK'),
                          onPressed: () {
                            setState(() {
                              data.add(ctrl.text);
                              checkbox.add(false);
                              ctrl.clear();
                            });
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  }
              );
            }

        )

    );
  }
  Widget buildList() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(

          child: Padding(
            padding: const EdgeInsets.all(20.0),

            child: Row(children: <Widget>[
              new Checkbox(
                value: checkbox[index],
                onChanged: (bool newValue){
                  checkbox[index]=newValue;
                  setState(() {
                  });
                },
              ),
              Text(data[index]),
            ],),
          ),
        );
      },
    );
  }
}