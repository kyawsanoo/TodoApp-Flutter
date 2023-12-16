import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/views/screens/list_screen.dart';

import '../../providers/data_provider.dart';



class CreateScreen extends StatefulWidget {

  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();

}

class _CreateScreenState extends State<CreateScreen> {
  // declare a GlobalKey
  final _formKey = GlobalKey<FormState>();
  // declare a variable to keep track of the input text
  String _name = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

      return Scaffold(
          appBar: AppBar(
            title: const Text('Create Todo', style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),),
          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 30),
              child:
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Enter task name',
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Can\'t be empty';
                        }
                        if (text.length < 4) {
                          return 'Too short';
                        }
                        return null;
                      },
                      onChanged: (text) => setState(() => _name = text),
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(width: 200,
                      child:
                            Consumer<DataProvider>(builder: (context, dataProvider, child){
                                return
                                    dataProvider.loading? Center(
                                            child: Container(
                                            child: const CircularProgressIndicator(),
                                            ),
                                    )
                                    :
                                      ElevatedButton(
                                        onPressed: _name.isNotEmpty ? _submit : null,
                                        child: Text(
                                          'Create',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      );
                            }

                            )
                        )
                    ],
                ),
              )

          )

      );

  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      var dataProvider = Provider.of<DataProvider>(context, listen: false);
      await dataProvider.callCreateTodoApi(this, _name);
      if (dataProvider.isBack) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Created todo successfully.", style: TextStyle(fontSize: 18,
            color: Colors.white,)),
        ));
        /*Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListScreen(),

          ),
        );*/
        /*Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => ListScreen()
            )
        );*/
        Navigator.pop(context, true);//true for isCreated bool argument to list screen
      }
    }
  }


}
