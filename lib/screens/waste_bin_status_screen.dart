import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:developer';
import '../models/bin_model.dart';
import '../providers/bin_provider.dart';

class WasteBinStatusScreen extends StatelessWidget {
  const WasteBinStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final binProvider = Provider.of<BinProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      binProvider.startListeningToBinChanges('sensor1');
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Waste Bin Status'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.green,
      ),
      body: Consumer<BinProvider>(
        builder: (context, binProvider, child) {
          if (binProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return StreamBuilder<BinModel>(
            stream: binProvider.binStream,
            builder: (context, snapshot) {
              log("📌 Stream Snapshot State: ${snapshot.connectionState}");
              log("📌 Has Data: ${snapshot.hasData}");
              log("📌 Has Error: ${snapshot.hasError}");

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error fetching data: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(
                  child: Text(
                    'No bin data available!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                final bin = snapshot.data!;
                return Column(
                  children: [
                    _buildWasteBinCard(context, binProvider.wasteLevel, bin),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/map-screen');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                      child: const Text(
                        'View on Map',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildWasteBinCard(BuildContext context, double wasteLevel, BinModel bin) {
    Color getWasteLevelColor(double level) {
      if (level >= 0 && level <= 50) {
        return Colors.green;
      } else if (level > 50 && level <= 80) {
        return Colors.orange;
      } else {
        return Colors.red;
      }
    }

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bin ID: ${bin.id}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Location: ${bin.location}",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 13.0,
                animation: true,
                percent: wasteLevel / 100,
                center: Text(
                  "${wasteLevel.toStringAsFixed(1)}%",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                progressColor: getWasteLevelColor(wasteLevel),
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Colors.grey[300] ?? Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
