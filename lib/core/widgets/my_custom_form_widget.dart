// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../features/station_tasks/presentation/widgets/date_picker_widget.dart';

class MyCustomFormWidget extends StatefulWidget {
  static const String FIELD_NAME = "field_name";
  static const String FORM_FIELD_TYPE = "form_field_type";
  static const String INITIAL_VALUE = "initial_value";
  static const String VALUES_LIST = "values_list";
  static const String IS_AUTO_FOCUS = "is_auto_focus";
  static const String NEXT_FOCUS_FIELD = "next_focus_field";
  static const String ERROR_TEXT = "error_text";

  final String formTitle;
  final List<Map<String, dynamic>> formFieldsMapList;
  final void Function(Map<String, TextEditingController>) onSaveFn;
  const MyCustomFormWidget({
    super.key,
    required this.formFieldsMapList,
    required this.formTitle,
    required this.onSaveFn,
  });

  @override
  State<MyCustomFormWidget> createState() => _MyCustomFormWidgetState();
}

class _MyCustomFormWidgetState extends State<MyCustomFormWidget> {
  final formKey = GlobalKey<FormState>();
  Map<String, TextEditingController> contorllers = {};
  Map<String, FocusNode> focusNodes = {};

  @override
  void initState() {
    super.initState();
    for (var field in widget.formFieldsMapList) {
      contorllers[field[MyCustomFormWidget.FIELD_NAME]] =
          TextEditingController();
      focusNodes[field[MyCustomFormWidget.FIELD_NAME]] = FocusNode();
    }
    log("number of conterollers = ${contorllers.length}");
  }

  @override
  void didUpdateWidget(covariant MyCustomFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // contorllers.forEach((fieldName, controller) {
    //   controller.clear();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Center(
            child: SelectableText(
              widget.formTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          StatefulBuilder(
            builder: (context, setState) => Form(
              key: formKey,
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                children: [
                  ...formFieldsBuilder(),
                  //* Buttons Paddinated Row
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //* save button
                        TextButton(
                          onPressed: () async {
                            final form = formKey.currentState;
                            if (form!.validate()) {
                              // form.save();
                              // contorllers.forEach((fieldName, controller) {
                              //   log("$fieldName = ${controller.text}");
                              // });
                              widget.onSaveFn(contorllers);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                    Text("Error: form validation Error!!! "),
                                duration: Duration(seconds: 3),
                              ));
                            }
                          },
                          child: const SizedBox(
                              height: 40,
                              width: 100,
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                        const SizedBox(width: 15),
                        //* validate button
                        ElevatedButton(
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
    focusNodes.forEach((fieldName, focusNode) {
      focusNode.dispose();
    });
    contorllers.forEach((fieldName, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  List<Widget> formFieldsBuilder() {
    List<Widget> formFields = [];
    for (var formFieldMap in widget.formFieldsMapList) {
      switch (formFieldMap[MyCustomFormWidget.FORM_FIELD_TYPE]) {
        case DateTime:
          formFields.add(DatePickerWidget(
            initDate: formFieldMap[MyCustomFormWidget.INITIAL_VALUE],
            updateDate: (updateDate) {
              var controller =
                  contorllers[formFieldMap[MyCustomFormWidget.FIELD_NAME]]!;
              controller.text = updateDate.toIso8601String();
            },
            controller:
                contorllers[formFieldMap[MyCustomFormWidget.FIELD_NAME]],
            isAutoFocus: formFieldMap[MyCustomFormWidget.IS_AUTO_FOCUS],
            focusNode: focusNodes[formFieldMap[MyCustomFormWidget.FIELD_NAME]],
            onPressTab: () => FocusScope.of(context).requestFocus(
                focusNodes[formFieldMap[MyCustomFormWidget.NEXT_FOCUS_FIELD]]),
          ));
          break;
        case int:
          formFields.add(MyCustomTextFormFieldWidget<int>(
            // errorText: formFieldMap[MyCustomFormWidget.ERROR_TEXT],
            fieldName: formFieldMap[MyCustomFormWidget.FIELD_NAME],
            controller:
                contorllers[formFieldMap[MyCustomFormWidget.FIELD_NAME]]!,
            isAutoFocused: formFieldMap[MyCustomFormWidget.IS_AUTO_FOCUS],
            focusNode: focusNodes[formFieldMap[MyCustomFormWidget.FIELD_NAME]]!,
            nextFocustRequest: () => FocusScope.of(context).requestFocus(
                focusNodes[formFieldMap[MyCustomFormWidget.NEXT_FOCUS_FIELD]]),
          ));
          break;
        case double:
          formFields.add(MyCustomTextFormFieldWidget<double>(
            fieldName: formFieldMap[MyCustomFormWidget.FIELD_NAME],
            controller:
                contorllers[formFieldMap[MyCustomFormWidget.FIELD_NAME]]!,
            isAutoFocused: formFieldMap[MyCustomFormWidget.IS_AUTO_FOCUS],
            focusNode: focusNodes[formFieldMap[MyCustomFormWidget.FIELD_NAME]]!,
            nextFocustRequest: () => FocusScope.of(context).requestFocus(
                focusNodes[formFieldMap[MyCustomFormWidget.NEXT_FOCUS_FIELD]]),
            // errorText: formFieldMap[MyCustomFormWidget.ERROR_TEXT],
          ));
          break;
        case List<String>:
          formFields.add(MyCustomDropDownSearchWidget<String>(
            items: formFieldMap[MyCustomFormWidget.VALUES_LIST],
            label: formFieldMap[MyCustomFormWidget.FIELD_NAME],
            controller:
                contorllers[formFieldMap[MyCustomFormWidget.FIELD_NAME]],
            selectedItem: formFieldMap[MyCustomFormWidget.INITIAL_VALUE],
            isAutoFocused: formFieldMap[MyCustomFormWidget.IS_AUTO_FOCUS],
            focusNode: focusNodes[formFieldMap[MyCustomFormWidget.FIELD_NAME]]!,
            nextFocustRequest: () => FocusScope.of(context).requestFocus(
                focusNodes[formFieldMap[MyCustomFormWidget.NEXT_FOCUS_FIELD]]),
            errorText: formFieldMap[MyCustomFormWidget.ERROR_TEXT],
          ));
          break;
        default:
          formFields.add(MyCustomTextFormFieldWidget<String>(
            // errorText: formFieldMap[MyCustomFormWidget.ERROR_TEXT],
            fieldName: formFieldMap[MyCustomFormWidget.FIELD_NAME],
            controller:
                contorllers[formFieldMap[MyCustomFormWidget.FIELD_NAME]]!,
            isAutoFocused: formFieldMap[MyCustomFormWidget.IS_AUTO_FOCUS],
            focusNode: focusNodes[formFieldMap[MyCustomFormWidget.FIELD_NAME]]!,
            nextFocustRequest: () => FocusScope.of(context).requestFocus(
                focusNodes[formFieldMap[MyCustomFormWidget.NEXT_FOCUS_FIELD]]),
          ));
      }
    }
    return formFields;
  }
}

class MyCustomDropDownSearchWidget<T> extends StatelessWidget {
  final List<T> items;
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final T? selectedItem;
  final Widget Function(BuildContext context, T item, bool isSelected)?
      itemBuilder;
  final List<T> Function(List<T>)? favoriteItems;
  final String Function(T)? itemAsString;
  final bool isAutoFocused;
  final FocusNode? focusNode;
  final void Function()? nextFocustRequest;
  final String? errorText;
  const MyCustomDropDownSearchWidget(
      {super.key,
      required this.items,
      this.controller,
      this.label,
      this.hint,
      this.selectedItem,
      this.itemBuilder,
      this.favoriteItems,
      this.itemAsString,
      this.isAutoFocused = false,
      this.focusNode,
      this.nextFocustRequest,
      this.errorText});

  void fakeTap() async {
    GestureBinding.instance.handlePointerEvent(const PointerDownEvent(
      position: Offset(200, 300),
    ));
    await Future.delayed(const Duration(milliseconds: 500));
    GestureBinding.instance.handlePointerEvent(const PointerUpEvent(
      position: Offset(200, 300),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      width: 300,
      child: RawKeyboardListener(
        autofocus: false,
        focusNode: focusNode ?? FocusNode(),
        onKey: (event) {
          if (event.isKeyPressed(LogicalKeyboardKey.tab)) {
            if (nextFocustRequest != null) {
              nextFocustRequest!();
            }
          }
        },
        child: DropdownSearch<T>(
          key: UniqueKey(),
          // asyncItems: (filter) => getData(context, filter),
          selectedItem: selectedItem,
          items: items,
          itemAsString: itemAsString,
          compareFn: (i, s) => i == s,
          onChanged: (item) {
            if (item != null) {
              log("Selected item is => $item");
              if (controller != null) {
                if (itemAsString != null) {
                  controller!.text = itemAsString!(item);
                } else {
                  controller!.text = item.toString();
                }
              }
            }
          },
          // autoValidateMode: AutovalidateMode.always,
          validator: (value) {
            log('selected $label = $value');
            if (value == null) return errorText ?? "please Select value";
          },
          clearButtonProps: const ClearButtonProps(icon: Icon(Icons.close)),
          dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
            labelText: label,
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          )),
          popupProps: PopupPropsMultiSelection.menu(
            isFilterOnline: true,
            showSelectedItems: true,
            showSearchBox: true,
            itemBuilder: itemBuilder,
            favoriteItemProps: FavoriteItemProps(
              showFavoriteItems: true,
              favoriteItems: favoriteItems,
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomTextFormFieldWidget<T> extends StatelessWidget {
  final String fieldName;
  // final T? initValue;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isAutoFocused;
  final void Function()? nextFocustRequest;
  final String? errorText;
  const MyCustomTextFormFieldWidget({
    super.key,
    required this.fieldName,
    required this.controller,
    required this.focusNode,
    // this.initValue,
    this.isAutoFocused = false,
    this.nextFocustRequest,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      width: 300,
      child: RawKeyboardListener(
        autofocus: isAutoFocused,
        focusNode: focusNode,
        onKey: (event) {
          if (event.isKeyPressed(LogicalKeyboardKey.tab)) {
            nextFocustRequest!();
          }
        },
        child: TextFormField(
          key: UniqueKey(),
          controller: controller,
          // initialValue: initValue.toString(),
          // focusNode: focusNode,
          // textInputAction: TextInputAction.previous,
          // autofocus: true,
          // onFieldSubmitted: (v) {
          //   nextFocustRequest!();
          // },
          // initialValue: header.name,
          decoration: InputDecoration(
            labelText: fieldName,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: controller.text.isEmpty
                ? Container(
                    width: 0,
                  )
                : IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => controller.clear(),
                  ),
            errorText: errorText,
          ),
          keyboardType: (T is int)
              ? TextInputType.number
              : (T is double)
                  ? const TextInputType.numberWithOptions(
                      signed: true, decimal: true)
                  : TextInputType.text,
          validator: (value) {
            if (value!.isEmpty) return "please input value";
            bool validateResult;
            if (T == int) {
              try {
                int.parse(value);
                validateResult = true;
                log('$fieldName $value validation = $validateResult');
              } catch (e) {
                validateResult = false;
                return "the value must to be number";
              }
            } else if (T == double) {
              try {
                double.parse(value);
                validateResult = true;
                log('$fieldName $value validation = $validateResult');
              } catch (e) {
                validateResult = false;
                return "the value must to be number of type double";
              }
            } else {
              validateResult = value.runtimeType == T;
              log('$fieldName "$value" validation = $validateResult');
            }
            if (!validateResult) {
              return "invalid data input";
            }
            return null;
          },
          onSaved: (value) {
            if (T == int) {
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
          // onTap: () {},
        ),
      ),
    );
  }
}
