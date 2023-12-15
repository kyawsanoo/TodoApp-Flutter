import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/views/screens/create_screen.dart';
import 'package:todoapp/views/screens/edit_screen.dart';

import '../../models/data.dart';
import '../../providers/data_provider.dart';

class ListScreen extends StatefulWidget {

  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();

}

class _ListScreenState extends State<ListScreen> {
  late List<Data> todos;


  @override
  void initState() {
    super.initState();
    Provider.of<DataProvider>(context, listen: false).fetchTodoList(context);
    if (kDebugMode) {
      print('initState');
    }
  }

  @override
  Widget build(BuildContext context) {
    final  dataProvider = Provider.of<DataProvider>(context);
    todos = dataProvider.apiTodoListResponse.data!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App', style: TextStyle(
          fontSize: 18,
          color: Colors.black87,
        ),),
      ),
      body:

      Container(
        padding: const EdgeInsets.only(left: 10, right:10),
        child: dataProvider.loading
            ? Center(
                child: Container(
                  child: const CircularProgressIndicator(),
                ),
              )
            :
            RefreshIndicator(
            onRefresh: _pullRefresh,
                child:
                todos.isNotEmpty?
                  ListView.builder(
                        shrinkWrap: true,
                        itemCount: todos.length,
                        itemBuilder: (context, index) {

                          return Card(
                              child: Column(children: [
                                ListTile(
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Name: ${todos[index].todoName!}",
                                        textDirection: TextDirection.ltr,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text("isComplete: ${todos[index].isComplete == null? "not known": todos[index].isComplete!}"),
                                      const SizedBox(
                                        height: 10,
                                      ),

                                    ],
                                  ),
                                  onTap: () {
                                                              },
                                ),
                          ListTile(title:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                  ButtonTheme(
                                  minWidth: 100.0,
                                  height: 50.0,
                                  child:
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      side: const BorderSide(
                                      color: Colors.black45,
                                    ),
                                    ),
                                    onPressed: () async {
                                      /*Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => const EditScreen(),
                                          settings: RouteSettings(
                                            arguments: todos[index],
                                          ),
                                      ),*/
                                      await  Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => const EditScreen(),
                                        settings: RouteSettings(
                                          arguments: todos[index],
                                        ),
                                      )
                                      ).then((isCompleteUpdated){
                                        /*setState(() {
                                          if (kDebugMode) {
                                            print('isCompleteUpdated: $isCompleteUpdated');
                                          }
                                        });*/
                                        if (kDebugMode) {
                                          print('isCompleteUpdated: $isCompleteUpdated');
                                        }
                                        if(isCompleteUpdated!=null && isCompleteUpdated){
                                          //refresh the page
                                          _pullRefresh();
                                        }
                                       });

                                    },
                                    child: const Text("Edit", style: TextStyle(fontSize: 18,
                                      color: Colors.black87,),),
                                  )),
                                  const SizedBox(width: 10,),
                              ButtonTheme(
                                minWidth: 100.0,
                                //height: 50.0,
                                child:
                                OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.black, side: const BorderSide(
                                      color: Colors.black45,
                                    ),
                                    ),
                                    onPressed: () {
                                      _dialogBuilder(context, todos[index]);
                                    },
                                    child: const Text("Delete", style: TextStyle(fontSize: 18,
                                      color: Colors.black87,),),
                                  )),
                                ],)
                          )

                              ],)


                          );
                        },
                      ):
                  const Center(child :Text("Todo list is empty and create new"))
            )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //Navigator.pushNamed(context, '/edit_screen');
          /*Navigator.pushNamed(
            context,
            '/edit_screen',
            arguments: dataProvider.apiResponse.data,
          );*/
          /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditScreen(todo: dataProvider.apiResponse.data!.first),
            ),
          );*/
          /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateScreen(),
            ),
          );*/
          await  Navigator.push(context, MaterialPageRoute(
            builder: (context) => const CreateScreen(),

          )
          ).then((isCreated){
            if (kDebugMode) {
              print('isCreated: $isCreated');
            }
            if(isCreated != null && isCreated){
              //refresh the page
              _pullRefresh();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    setState(() {
      Provider.of<DataProvider>(context, listen: false).fetchTodoList(context);
    });
  }

  Future<void> _dialogBuilder(BuildContext context, Data todo) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return
          ScaffoldMessenger(child: Builder(builder: (context){
          return Scaffold(
            backgroundColor: Colors.transparent,
              body: AlertDialog(
            title: const Text('Confirm to delete'),
            content: const Text(
                'Are you sure to delete?'

            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),

              Consumer<DataProvider>(builder: (context, dataProvider, child) {
                return
                  dataProvider.loading ?
                  SizedBox(width: 20, height: 20, child: CircularProgressIndicator(),)

                      :
                  TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme
                            .of(context)
                            .textTheme
                            .labelLarge,
                      ),
                      child: const Text('Ok'),
                      onPressed: () async {
                        var dataProvider = Provider.of<DataProvider>(
                            context, listen: false);
                        await dataProvider.callDeleteTodoApi(this, todo.todoId);
                        if (dataProvider.isBack){
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Deleted successfully."),
                              )
                          );
                          await Future.delayed(const Duration(seconds: 1));

                          Navigator.of(context).pop();
                          _pullRefresh();

                        }

                      }
                  );
              })
            ],
          ));

        }));
      },
    );
  }

}
