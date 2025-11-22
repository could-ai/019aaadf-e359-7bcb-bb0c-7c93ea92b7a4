import 'package:flutter/material.dart';

void main() {
  runApp(const ChinaForecastApp());
}

class ChinaForecastApp extends StatelessWidget {
  const ChinaForecastApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pronóstico China',
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ForecastScreen(),
      },
    );
  }
}

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  // Datos simulados basados en la lógica de regresión lineal del script Python
  // Estos valores son aproximaciones visuales de lo que generaría el modelo lineal
  final List<Map<String, dynamic>> forecastData = const [
    {'year': 2025, 'gdp': 19.50, 'inflation': 1.85},
    {'year': 2026, 'gdp': 20.45, 'inflation': 1.78},
    {'year': 2027, 'gdp': 21.40, 'inflation': 1.71},
    {'year': 2028, 'gdp': 22.35, 'inflation': 1.64},
    {'year': 2029, 'gdp': 23.30, 'inflation': 1.57},
    {'year': 2030, 'gdp': 24.25, 'inflation': 1.50},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pronóstico China 2025-2030',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red[800],
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(),
              const SizedBox(height: 20),
              const Text(
                "Resultados del Modelo (Regresión Lineal)",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              _buildDataTable(context),
              const SizedBox(height: 20),
              _buildInfoCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.trending_up, size: 48, color: Colors.red[800]),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Análisis Macroeconómico",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Proyección de PIB e Inflación basada en datos históricos (2010-2023).",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.red[50]),
          columnSpacing: 20,
          columns: const [
            DataColumn(label: Text('Año', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('PIB (Trillions)', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Inflación (%)', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: forecastData.map((data) {
            return DataRow(cells: [
              DataCell(Text(
                data['year'].toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
              DataCell(Text("\$${data['gdp'].toStringAsFixed(2)} T")),
              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: data['inflation'] < 2.0 ? Colors.green[100] : Colors.orange[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "${data['inflation'].toStringAsFixed(2)}%",
                    style: TextStyle(
                      color: data['inflation'] < 2.0 ? Colors.green[800] : Colors.orange[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ]);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueGrey.shade100),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nota Técnica:",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
          ),
          SizedBox(height: 5),
          Text(
            "Este pronóstico utiliza un modelo de Regresión Lineal Simple (Python/Scikit-Learn). "
            "Los valores asumen una tendencia constante y no consideran crisis geopolíticas imprevistas.",
            style: TextStyle(fontSize: 12, color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}
