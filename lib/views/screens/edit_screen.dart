import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/data.dart';
import '../../providers/data_provider.dart';
import 'list_screen.dart';

class EditScreen extends StatefulWidget {

  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();

}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();
  String? selectedValue;
  List<String> selectionList = ["true", "false"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)!.settings.arguments as Data;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Todo", style: TextStyle(
          fontSize: 18,
          color: Colors.black87,
        ),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
            child: Form(
              key: formKey,
              child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('isComplete', style: TextStyle(fontSize: 14,
                  color: Colors.black87,), ),
                const SizedBox(height: 10,),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.only(right: 10, left: 10),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Colors.red),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  elevation: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select';
                    } else {
                      return null;
                    }
                  },
                  isExpanded: true,
                  hint: const Text("Please select"),
                  iconSize: 45,
                  iconEnabledColor: Colors.black,
                  icon: const Icon(
                    Icons.arrow_drop_down_sharp,
                    size: 15,
                  ),
                  value: selectedValue,
                  items:
                  selectionList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: SizedBox( width: 200, child: Text( value,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        ));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      debugPrint("chosen value: $value");
                      selectedValue = value;
                    });
                  },
                ),
              ],)

            ),
          ),
          SizedBox(
              width: 200,
              child:
                  Consumer<DataProvider>(builder: (context, dataProvider, child) {
                return dataProvider.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          final isValid = formKey.currentState!.validate();
                          if (!isValid) {
                            return;
                          } else {
                            debugPrint("validated: $isValid");
                            var dataProvider =
                                Provider.of<DataProvider>(context, listen: false);
                            await dataProvider.callUpdateTodoApi(
                                this, todo.todoId!, selectedValue == "true");
                            if (dataProvider.isBack) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Updated successfully.", style: TextStyle(fontSize: 18,
                                  color: Colors.white,),),
                              ));
                              /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ListScreen(),
                                ),
                              );*/
                              /*Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder:
                                      (context) =>
                                      ListScreen()
                                  )
                              );*/
                              Navigator.pop(context, true);//true for isCompleteUpdated bool argument to list screen
                            }
                          }
                        },
                        child: const Text(
                          "Update",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ));
              })
          )
        ],
      ),
    );
  }
}
