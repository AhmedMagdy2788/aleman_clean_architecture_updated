// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/widgets/my_custom_form_widget.dart';
import '../../bloc/station_tasks_bloc.dart';

class AddProductsDetailsPage extends StatelessWidget {
  static const String DATE = "Date";
  static const String CATEGORIES = "Categories";
  static const String PRODUCT_NAME = "Producrt Name";
  static const String PURCHASE_PRICE = "Purchase price";
  static const String SALE_PRICE = "Sale Price";
  final List<String> productsCategories;
  const AddProductsDetailsPage({super.key, required this.productsCategories});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          MyCustomFormWidget(
              formFieldsMapList: [
                {
                  MyCustomFormWidget.FIELD_NAME: "Date",
                  MyCustomFormWidget.FORM_FIELD_TYPE: DateTime,
                  MyCustomFormWidget.INITIAL_VALUE: DateTime.now(),
                  MyCustomFormWidget.VALUES_LIST: const [],
                  MyCustomFormWidget.IS_AUTO_FOCUS: true,
                  MyCustomFormWidget.NEXT_FOCUS_FIELD: "Categories",
                  MyCustomFormWidget.ERROR_TEXT: "Invalid Date",
                },
                {
                  MyCustomFormWidget.FIELD_NAME: CATEGORIES,
                  MyCustomFormWidget.FORM_FIELD_TYPE: List<String>,
                  MyCustomFormWidget.INITIAL_VALUE: null,
                  MyCustomFormWidget.VALUES_LIST: productsCategories,
                  MyCustomFormWidget.IS_AUTO_FOCUS: false,
                  MyCustomFormWidget.NEXT_FOCUS_FIELD: "Producrt Name",
                  MyCustomFormWidget.ERROR_TEXT:
                      "Select the category of the product...",
                },
                const {
                  MyCustomFormWidget.FIELD_NAME: PRODUCT_NAME,
                  MyCustomFormWidget.FORM_FIELD_TYPE: String,
                  MyCustomFormWidget.INITIAL_VALUE: null,
                  MyCustomFormWidget.VALUES_LIST: null,
                  MyCustomFormWidget.IS_AUTO_FOCUS: false,
                  MyCustomFormWidget.NEXT_FOCUS_FIELD: "purchase price",
                  MyCustomFormWidget.ERROR_TEXT: "Product Name is Required...",
                },
                const {
                  MyCustomFormWidget.FIELD_NAME: "Purchase price",
                  MyCustomFormWidget.FORM_FIELD_TYPE: double,
                  MyCustomFormWidget.INITIAL_VALUE: 0,
                  MyCustomFormWidget.VALUES_LIST: null,
                  MyCustomFormWidget.IS_AUTO_FOCUS: false,
                  MyCustomFormWidget.NEXT_FOCUS_FIELD: "Sale Price",
                  MyCustomFormWidget.ERROR_TEXT:
                      "Enter the purchase price or enter 0 if not ready yet...",
                },
                const {
                  MyCustomFormWidget.FIELD_NAME: SALE_PRICE,
                  MyCustomFormWidget.FORM_FIELD_TYPE: double,
                  MyCustomFormWidget.INITIAL_VALUE: null,
                  MyCustomFormWidget.VALUES_LIST: null,
                  MyCustomFormWidget.IS_AUTO_FOCUS: false,
                  MyCustomFormWidget.NEXT_FOCUS_FIELD: "Date",
                  MyCustomFormWidget.ERROR_TEXT: "Sales Price is required...",
                },
              ],
              formTitle: "Adding New Product and its sale and purchase prices",
              onSaveFn: (controllersMap) {
                DateTime date = DateFormat('EEEE, dd-MMM-yyyy')
                    .parse(controllersMap[DATE]!.text);
                log("Save Date $date");
                log(controllersMap[CATEGORIES]!.text);
                log(controllersMap[PRODUCT_NAME]!.text);
                log(controllersMap[PURCHASE_PRICE]!.text);
                log(controllersMap[SALE_PRICE]!.text);
                // final dateString = 'Tuesday, 25-Apr-2023';
                // final format = DateFormat('EEEE, dd-MMM-yyyy');
                // final dateTime = format.parse(dateString);

                BlocProvider.of<StationTasksBloc>(context).add(
                  SaveNewProductDetailsEvent(
                    context,
                    date: date,
                    category: controllersMap[CATEGORIES]!.text,
                    productName: controllersMap[PRODUCT_NAME]!.text,
                    purchasePrice:
                        double.parse(controllersMap[PURCHASE_PRICE]!.text),
                    salePrice: double.parse(controllersMap[SALE_PRICE]!.text),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
