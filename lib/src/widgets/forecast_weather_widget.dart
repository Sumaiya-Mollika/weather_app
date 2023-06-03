import 'package:flutter/material.dart';
import 'package:weather_app/src/config/base.dart';
import 'package:weather_app/src/helper/global_helper.dart';

class ForecastWeatherWidget extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
      child: DataTable(
        showBottomBorder: false,
        columnSpacing: 10,
        headingRowHeight: 35,
        horizontalMargin: 10,
        dividerThickness: 1,
        showCheckboxColumn: false,
        columns: const <DataColumn>[
          DataColumn(
            label: Text('Day'),
          ),
          DataColumn(
            label: Text(''),
          ),
          DataColumn(
            label: Text('Status'),
          ),
          DataColumn(
            label: Text('Temp\nmax / min'),
          ),
        ],
        rows: weatherC.weatherForecast
            .map((data) => DataRow(
                  cells: <DataCell>[
                    DataCell(Text(formatDate(date: data!.dtTxt.toString()) == formatDate(date: DateTime.now().toString())
                        ? 'Today'
                        : formatDayName(date: data.dtTxt.toString()))),
                    DataCell(Image.asset(
                      'assets/weather/${data.weather!.first.icon}.png',
                      height: 20,
                      width: 20,
                    )),
                    DataCell(Text(data.weather!.first.description!)),
                    DataCell(Text('${data.main!.tempMax}\u00B0 / ${data.main!.tempMin}\u00B0')),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
