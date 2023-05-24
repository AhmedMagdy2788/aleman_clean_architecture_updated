import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/station_tasks_bloc.dart';
import '../../bloc/tablable_entities/station_details.dart';
import '../../widgets/date_picker_widget.dart';
import '../../widgets/stations/tanks_measurements_table_widget.dart';
import '../station_page.dart';

class DailyReportPage extends StatefulWidget {
  final DailyReport? dailyReport;

  const DailyReportPage({required this.dailyReport, super.key});

  @override
  State<DailyReportPage> createState() => _DailyReportPageState();
}

class _DailyReportPageState extends State<DailyReportPage> {
  // late DateTime reportDate;
  // late final DateTime initDate;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initDate = StationPage.of(context)!.initDate;
    // reportDate = initDate;
  }

  @override
  void didUpdateWidget(covariant DailyReportPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Topbar(
            initDate: widget.dailyReport!.currentDate,
            prevDate: widget.dailyReport!.prevDate,
            dateUpdate: (selecteDate) {
              setState(() {
                // reportDate = selecteDate;
                BlocProvider.of<StationTasksBloc>(context)
                    .add(ShowDailyReportPageEvent(
                  context,
                  reportDate: selecteDate,
                  station: StationPage.of(context)!.station,
                ));
              });
            },
          ),
          Flexible(
            flex: 11,
            child: Row(
              children: [
                Flexible(
                  flex: 6,
                  child: (widget.dailyReport == null)
                      ? Center(
                          child: Text(
                            "No Daily report at date: ${DateFormat("dd-MMM-yyyy").format(StationPage.of(context)!.initDate)}",
                            style: const TextStyle(fontSize: 24),
                          ),
                        )
                      : Center(
                          child: Column(
                            children: [
                              Card(
                                elevation: 8,
                                borderOnForeground: true,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      TanksMeasurementsTableWidget(
                                        dailyReport: widget.dailyReport!,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                )
                // const Flexible(flex: 3, child: PdfPage())
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Topbar extends StatelessWidget {
  final DateTime initDate;
  final DateTime prevDate;
  final dynamic Function(DateTime) dateUpdate;
  const Topbar(
      {super.key,
      required this.initDate,
      required this.dateUpdate,
      required this.prevDate});

  @override
  Widget build(BuildContext context) {
    // StationEntity stationEntity = StationPage.of(context)!.station;
    return Container(
      height: 75,
      // width: double.infinity,
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.background),
      // constraints: const BoxConstraints(minWidth: 500),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Previous Daily Date",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.calendar_today),
                const SizedBox(width: 8),
                SelectableText(
                  "${DateFormat('EEEE').format(prevDate)}, ${DateFormat('dd-MMM-yyyy').format(prevDate)}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Daily Report Date",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                DatePickerWidget(
                  initDate: initDate,
                  updateDate: (selectedDate) => dateUpdate(selectedDate),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
