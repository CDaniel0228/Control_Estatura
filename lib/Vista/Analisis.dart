// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Constantes.dart';
import '../Modelo/Usuario.dart';


class Analisis extends StatelessWidget {
  List<Usuario> chartData;
  Analisis(this.chartData);
  
  final List<ChartData> chartDat = [
            ChartData(2010, 35, 23),
            ChartData(2011, 38, 49),
            ChartData(2012, 34, 12),
            ChartData(2013, 52, 33),
            ChartData(2014, 40, 30)
        ];
 @override
    Widget build(BuildContext context) {
        
        return Scaffold(
          appBar: AppBar(
          title: Text('Analisis'),
          centerTitle: true,
          backgroundColor: headerColor,
        ),
            body: Center(
                child: panel(context)    
            )
        );
    }
    Widget panel(BuildContext context) {
    return Container(
        child: Column(
      children: [
       grafica()

       ],
    ));
  }
  Widget grafica(){
    return Container(
                    child: SfCartesianChart(
                      enableSideBySideSeriesPlacement: false,
                        series: <ChartSeries<Usuario, double>>[
                            // Renders column chart
                            
                            ColumnSeries<Usuario, double>(
                                dataSource: chartData,
                                xValueMapper: (Usuario data, _) => data.estatura,
                                yValueMapper: (Usuario data, _) => data.peso,
                                 width: 0.5, 

                            ),
                            ColumnSeries<Usuario, double>( 
                                opacity: 0.9,
                                width: 0.4,
                                dataSource: chartData,
                                xValueMapper: (Usuario data, _) => data.estatura,
                                yValueMapper: (Usuario data, _) => data.peso, //establecido
                                
                            )
                        ]
                    )
                );
  }
  
}
    class ChartData {
        ChartData(this.x, this.y, this.y1);
        final int x;
        final double y;
        final double y1;
    }