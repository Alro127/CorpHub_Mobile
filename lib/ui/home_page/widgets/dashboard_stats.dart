import 'package:flutter/material.dart';

class DashboardStats extends StatelessWidget {
  const DashboardStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _buildStatCard(
            Icon(Icons.bar_chart, color: Colors.blue),
            'Total',
            '23',
            Colors.blue,
          ),
          _buildStatCard(
            Icon(Icons.fiber_new, color: Colors.red),
            'New',
            '2',
            Colors.red,
          ),
          _buildStatCard(
            Icon(Icons.hourglass_empty, color: Colors.orange),
            'Processing',
            '3',
            Colors.orange,
          ),
          _buildStatCard(
            Icon(Icons.check_circle, color: Colors.green),
            'Completed',
            '10',
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(Icon icon, String title, String count, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            count,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
