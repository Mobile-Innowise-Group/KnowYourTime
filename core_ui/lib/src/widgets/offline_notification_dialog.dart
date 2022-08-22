import 'package:flutter/material.dart';

class OfflineNotificationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(
          height: 80,
          width: 100,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'No internet connection',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              const Icon(Icons.network_locked, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
