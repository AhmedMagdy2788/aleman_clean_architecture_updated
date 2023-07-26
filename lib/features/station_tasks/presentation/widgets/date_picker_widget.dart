import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  final DateTime initDate;
  final Function(DateTime date) updateDate;
  final TextEditingController? controller;
  final bool Function(DateTime)? onValidate;
  final void Function(DateTime)? onSave;
  final bool isAutoFocus;
  final FocusNode? focusNode;
  final Function()? onPressTab;
  final Function()? onPressEnter;

  const DatePickerWidget(
      {super.key,
      required this.initDate,
      required this.updateDate,
      this.controller,
      this.isAutoFocus = false,
      this.focusNode,
      this.onPressTab,
      this.onPressEnter,
      this.onValidate,
      this.onSave})
      : assert(onValidate == null || controller != null),
        assert(onSave == null || controller != null);

  @override
  State<StatefulWidget> createState() {
    return _DatePickerPage();
  }
}

class _DatePickerPage extends State<DatePickerWidget> {
  late DateTime pickedDate;
  late TextEditingController controller;
  final tempFocusNode = FocusNode();

  @override
  void initState() {
    pickedDate = widget.initDate;
    if (widget.controller != null) {
      controller = widget.controller!;
    } else {
      controller = TextEditingController();
    }
    controller.text =
        "${DateFormat('EEEE').format(widget.initDate)}, ${DateFormat('dd-MMM-yyyy').format(widget.initDate)}";
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    tempFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        width: 300,
        // height: MediaQuery.of(context).size.width / 3,
        child: Center(
            child: RawKeyboardListener(
          autofocus: widget.isAutoFocus,
          focusNode: widget.focusNode ?? tempFocusNode,
          onKey: (event) {
            if (event.isKeyPressed(LogicalKeyboardKey.tab)) {
              if (widget.onPressTab != null) widget.onPressTab!();
            }
            if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
              (widget.onPressEnter != null) ? widget.onPressEnter!() : onTap();
            }
          },
          child: TextFormField(
            controller: controller,
            //editing controller of this TextField
            decoration: InputDecoration(
                prefixIcon:
                    const Icon(Icons.calendar_today), //icon of text field
                labelText: "Select Date", //label text of field
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
            readOnly: true,
            //set it true, so that user will not able to edit text
            onTap: onTap,
            validator: (value) {
              if (value!.isEmpty) return "please input value";
              bool validateResult;
              try {
                // log(value);
                if (widget.onValidate != null) {
                  validateResult = widget.onValidate!(pickedDate);
                } else {
                  validateResult = true;
                }
                log('Date ${widget.controller!.text} validation = $validateResult');
                return null;
              } catch (e) {
                validateResult = false;
                return "the value must to be valid date string";
              }
            },
            onSaved: (value) {
              controller.text = pickedDate.toString();
              if (widget.onSave != null) {
                widget.onSave!(pickedDate);
              }
            },
          ),
        )));
  }

  void onTap() async {
    pickedDate = await showDatePicker(
          context: context,
          initialDate: widget.initDate,
          firstDate: DateTime(2020),
          //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime(2100),
          locale: Localizations.localeOf(context),
        ) ??
        widget.initDate;

    widget.updateDate(pickedDate);
    // if (widget.controller != null) {
    controller.text = pickedDate.toString();
    log('Date Controller value = ${controller.text}');
    // }
    log(pickedDate
        .toString()); //pickedDate output format => 2021-03-10 00:00:00.000
    String formattedDate =
        "${DateFormat('EEEE').format(pickedDate)}, ${DateFormat('dd-MMM-yyyy').format(pickedDate)}";
    setState(() {
      controller.text = formattedDate; //set output date to TextField value.
      log(formattedDate); //formatted date output using intl package =>  2021-03-16
    });
  }
}
