import 'package:flutter/material.dart';

class DashboardStats extends StatelessWidget {
  const DashboardStats({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 80),
      child: ListView(
        scrollDirection: Axis.horizontal,
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
      width: 120,
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 4),
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
          const SizedBox(height: 4),
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
    );
  }
}
