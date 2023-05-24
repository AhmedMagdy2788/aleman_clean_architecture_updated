// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/my_custom_form_widget.dart';
import '../../bloc/station_tasks_bloc.dart';
import '../../widgets/date_picker_widget.dart';
import '../station_page.dart';

class AddTanksDetailsPage extends StatelessWidget {
  final List<String> tanksProducts;
  const AddTanksDetailsPage({super.key, required this.tanksProducts});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: [
        // AddTanksDetailsSubPage(tanksProducts: tanksProducts),
        MyCustomFormWidget(
          formTitle: "Adding New Tanks and Its Content Type",
          formFieldsMapList: [
            {
              MyCustomFormWidget.FIELD_NAME: "Date",
              MyCustomFormWidget.FORM_FIELD_TYPE: DateTime,
              MyCustomFormWidget.INITIAL_VALUE: DateTime.now(),
              MyCustomFormWidget.VALUES_LIST: const [],
              MyCustomFormWidget.IS_AUTO_FOCUS: true,
              MyCustomFormWidget.NEXT_FOCUS_FIELD: "Name",
              MyCustomFormWidget.ERROR_TEXT: "Invalid Date",
            },
            const {
              MyCustomFormWidget.FIELD_NAME: "Name",
              MyCustomFormWidget.FORM_FIELD_TYPE: String,
              MyCustomFormWidget.INITIAL_VALUE: null,
              MyCustomFormWidget.VALUES_LIST: null,
              MyCustomFormWidget.IS_AUTO_FOCUS: false,
              MyCustomFormWidget.NEXT_FOCUS_FIELD: "Tank Products",
              MyCustomFormWidget.ERROR_TEXT: "Name is Required...",
            },
            {
              MyCustomFormWidget.FIELD_NAME: "Tank Products",
              MyCustomFormWidget.FORM_FIELD_TYPE: List<String>,
              MyCustomFormWidget.INITIAL_VALUE: null,
              MyCustomFormWidget.VALUES_LIST: tanksProducts,
              MyCustomFormWidget.IS_AUTO_FOCUS: false,
              MyCustomFormWidget.NEXT_FOCUS_FIELD: "Capacity",
              MyCustomFormWidget.ERROR_TEXT: "Select product for the tank...",
            },
            const {
              MyCustomFormWidget.FIELD_NAME: "Capacity",
              MyCustomFormWidget.FORM_FIELD_TYPE: int,
              MyCustomFormWidget.INITIAL_VALUE: null,
              MyCustomFormWidget.VALUES_LIST: null,
              MyCustomFormWidget.IS_AUTO_FOCUS: false,
              MyCustomFormWidget.NEXT_FOCUS_FIELD: "Date",
              MyCustomFormWidget.ERROR_TEXT: "Capacity is Required...",
            },
          ],
          onSaveFn: (controllersMap) {
            // log(controllersMap["Date"]!.text);
            // log(controllersMap["Name"]!.text);
            // log(controllersMap["Tank Products"]!.text);
            // log(controllersMap["Capacity"]!.text);

            BlocProvider.of<StationTasksBloc>(context).add(AddTankDetailsEvent(
              context,
              date: DateTime.parse(controllersMap["Date"]!.text),
              stationName: StationPage.of(context)!.station.name,
              tankCapacity: int.parse(controllersMap["Capacity"]!.text),
              tankName: controllersMap["Name"]!.text,
              tankProduct: controllersMap["Tank Products"]!.text,
            ));
          },
        ),
      ]),
    );
  }
}

class AddTanksDetailsSubPage extends StatefulWidget {
  final List<String> tanksProducts;
  const AddTanksDetailsSubPage({super.key, required this.tanksProducts});

  @override
  State<AddTanksDetailsSubPage> createState() => _AddTanksDetailsSubPageState();
}

class _AddTanksDetailsSubPageState extends State<AddTanksDetailsSubPage> {
  final formKey = GlobalKey<FormState>();
  late DateTime date;
  final dateController = TextEditingController();
  final tankNameController = TextEditingController();
  final productController = TextEditingController();
  final capacityController = TextEditingController();
  final FocusNode myFocusNode1 = FocusNode();
  final FocusNode myFocusNode2 = FocusNode();
  final FocusNode myFocusNode3 = FocusNode();
  final FocusNode myFocusNode4 = FocusNode();
  final FocusNode myFocusNode5 = FocusNode();

  @override
  void initState() {
    super.initState();

    // tankNameController.addListener(() => setState(() {}));
    // productController.addListener(() => setState(() {}));
    // capacityController.addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(AddTanksDetailsSubPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    tankNameController.clear();
    productController.clear();
    capacityController.clear();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    date = StationPage.of(context)!.initDate;
    // FocusScope.of(context).requestFocus(myFocusNode4);
    // dateController.text = DateTime.now().toIso8601String();
    // tankNameController.addListener(() => setState(() {
    //       // FocusScope.of(context).requestFocus(myFocusNode2);
    //     }));
    // productController.addListener(() => setState(() {}));
    // capacityController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 400,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          const Center(
            child: SelectableText(
              "Adding New Tanks and Its Content Type",
              style: TextStyle(fontSize: 20),
            ),
          ),
          StatefulBuilder(
            builder: (context, setState) => Form(
              key: formKey,
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                children: [
                  //* Date Field
                  DatePickerWidget(
                    initDate: date,
                    updateDate: (updateDate) {
                      date = updateDate;
                    },
                    controller: dateController,
                    isAutoFocus: true,
                    focusNode: myFocusNode1,
                    onPressTab: () =>
                        FocusScope.of(context).requestFocus(myFocusNode2),
                  ),
                  //* Tank Name Field
                  MyCustomTextFormFieldWidget<String>(
                    fieldName: "Tank Name",
                    controller: tankNameController,
                    focusNode: myFocusNode2,
                    isAutoFocused: false,
                    nextFocustRequest: () =>
                        FocusScope.of(context).requestFocus(myFocusNode3),
                  ),
                  //* Tank Product droupdown Field
                  MyCustomDropDownSearchWidget<String>(
                    items: widget.tanksProducts,
                    label: "Tank Products",
                    hint: 'Select the new tank contaning product',
                    controller: productController,
                    itemAsString: (p0) => p0.toString(),
                  ),
                  //* Tank Capacity Field
                  MyCustomTextFormFieldWidget<int>(
                    fieldName: "Tank Capacity",
                    controller: capacityController,
                    focusNode: myFocusNode4,
                    nextFocustRequest: () =>
                        FocusScope.of(context).requestFocus(myFocusNode5),
                  ),
                  //* Buttons Paddinated Row
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //* save button
                        ElevatedButton(
                          onPressed: () async {
                            final form = formKey.currentState;
                            if (form!.validate()) {
                              form.save();
                              log("data = ${date.toIso8601String()}");
                              log("Tank Name = ${tankNameController.text}");
                              log("Tank Product = ${productController.text}");
                              log("Tank Capacity = ${capacityController.text}");

                              BlocProvider.of<StationTasksBloc>(context)
                                  .add(AddTankDetailsEvent(
                                context,
                                date: date,
                                stationName:
                                    StationPage.of(context)!.station.name,
                                tankCapacity:
                                    int.parse(capacityController.text),
                                tankName: tankNameController.text,
                                tankProduct: productController.text,
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                    Text("Error: form validation Error!!! "),
                                duration: Duration(seconds: 3),
                              ));
                            }
                          },
                          child: const Text('Save'),
                        ),
                        const SizedBox(width: 15),
                        //* validate button
                        RawKeyboardListener(
                          autofocus: false,
                          focusNode: myFocusNode5,
                          onKey: (event) {
                            if (event.isKeyPressed(LogicalKeyboardKey.tab)) {
                              FocusScope.of(context).requestFocus(myFocusNode1);
                            } else if (event
                                .isKeyPressed(LogicalKeyboardKey.enter)) {
                              final form = formKey.currentState;
                              if (form!.validate()) {
                                log('form validate is success');
                              } else {
                                log('form validate is faild');
                              }
                            }
                          },
                          child: ElevatedButton(
                            onPressed: () {
                              final form = formKey.currentState;
                              if (form!.validate()) {
                                log('form validate is success');
                              } else {
                                log('form validate is faild');
                              }
                            },
                            clipBehavior: Clip.hardEdge,
                            // autofocus: false,
                            // focusNode: myFocusNode5,
                            // onFocusChange: (value) {
                            //   FocusScope.of(context).requestFocus(myFocusNode1);
                            // },
                            child: const Text("Validate"),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the focus nodes when the Form is disposed.
    myFocusNode1.dispose();
    myFocusNode2.dispose();
    myFocusNode3.dispose();
    myFocusNode4.dispose();
    myFocusNode5.dispose();
    dateController.dispose();
    tankNameController.dispose();
    productController.dispose();
    capacityController.dispose();
    super.dispose();
  }
}
