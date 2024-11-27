import 'package:flutter/material.dart';
import 'package:furnitur/utils/theme.dart';

class LoadingScreen extends StatelessWidget {
  final bool loading;
  const LoadingScreen({super.key, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: Stack(
              children: [
                const Opacity(
                  opacity: 0.6,
                  child: ModalBarrier(dismissible: false, color: Colors.black),
                ),
                Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 150,
                    height: 150,
                    padding: const EdgeInsets.all(50),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: CircularProgressIndicator(
                      backgroundColor: FurniColors.primary.withOpacity(0.3),
                      // strokeWidth: 10.0,
                      valueColor: const AlwaysStoppedAnimation<Color>(FurniColors.primary),
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
