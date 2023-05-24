import 'dart:developer';

import '/core/entities/tablable_entity.dart';
import 'package:flutter/material.dart';

import '../../widgets/stations/page_header.dart';

class AddEntityFormPage<T> extends StatelessWidget {
  final TableDataSource<T> tableDataSource;
  const AddEntityFormPage({super.key, required this.tableDataSource});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: [
        const PageHeader(
            title: "Add New Customer",
            subTitle:
                "Form to add new cusotmer account to the station, it should first create the customer in the company, then add a new account to him in station."),
        buildInputForm(context)
      ]),
    );
  }

  Widget buildInputForm(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    // Tablable instance = widget.table.createEmptyInstance();

    return Expanded(
      flex: 1,
      child: Container(
        // height: 400,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: StatefulBuilder(
          builder: (context, setState) => Form(
            key: formKey,
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              children: [
                ...inputFormFields(context, tableDataSource),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final form = formKey.currentState;
                          if (form!.validate()) {
                            form.save();
                            //todo add event to save entity instance
                            // bool isAdded = await addCusotmer( instance);
                            if (true /*isAdded*/) {
                              //todo add event form saved successfuly
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(const SnackBar(
                              //   content: Text("form saved successflly"),
                              //   duration: Duration(seconds: 3),
                              // ));
                            } else {
                              //todo add event faild to save form
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(const SnackBar(
                              //   content: Text("Faild to save form"),
                              //   duration: Duration(seconds: 3),
                              // ));
                            }
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Error: form validation Error!!! "),
                              duration: Duration(seconds: 3),
                            ));
                          }
                          // Navigator.of(context).pop();
                        },
                        child: const Text('Save'),
                      ),
                      const SizedBox(width: 15),
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.of(context).pop();
                          final form = formKey.currentState;
                          if (form!.validate()) {
                            log('form validate is success');
                          } else {
                            log('form validate is faild');
                          }
                        },
                        child: const Text("Validate"),
                      ),
                      const SizedBox(width: 15),
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.of(context).pop();
                        },
                        child: const Text("Exit"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> inputFormFields(
      BuildContext context, TableDataSource<T> instance) {
    List<Widget> inputFormFieldsWidgets = [];
    instance.columns.forEach((columnName, type) {
      if (type == DateTime) {
        inputFormFieldsWidgets
            .add(dateFormField(context, columnName, instance));
      } else {
        inputFormFieldsWidgets
            .add(textFormFieldWidget(columnName, type, instance));
      }
    });
    return inputFormFieldsWidgets;
  }

  Widget textFormFieldWidget(
      String columnName, Type type, TableDataSource<T> instance) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      width: 200,
      child: TextFormField(
        key: UniqueKey(),
        // initialValue: header.name,
        decoration: InputDecoration(labelText: columnName),
        keyboardType: (type is int)
            ? TextInputType.number
            : (type is double)
                ? const TextInputType.numberWithOptions(
                    signed: true, decimal: true)
                : TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) return "please input value";
          bool validateResult;
          if (type == int) {
            try {
              int.parse(value);
              validateResult = true;
              log('$columnName $value validation = $validateResult');
            } catch (e) {
              validateResult = false;
              return "the value must to be number";
            }
          } else {
            validateResult = value.runtimeType == type;
            log('$columnName "$value" validation = $validateResult');
          }
          if (!validateResult) {
            return "invalid data input";
          }
          return null;
        },
        onSaved: (value) {
          if (type == int) {
            try {
              int number = int.parse(value!);
              //todo
              // instance.setParametersData(columnName, number);
            } catch (e) {
              log("Invalid parsing for value => $value");
            }
          } else {
            //todo
            // instance.setParametersData(columnName, value);
          }
        },
        onTap: () {},
      ),
    );
  }

  Widget dateFormField(
      BuildContext context, String columnName, TableDataSource<T> instance) {
    TextEditingController dateCtl = TextEditingController();
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      width: 300,
      child: TextFormField(
        controller: dateCtl,
        keyboardType: TextInputType.datetime,
        decoration: const InputDecoration(
          labelText: "Date",
          hintText: "Ex. Insert your dob",
        ),
        onTap: () async {
          DateTime? date = DateTime(1900);
          FocusScope.of(context).requestFocus(FocusNode());

          date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100));

          dateCtl.text = date!.toString();
        },
      ),
    );
  }
}
