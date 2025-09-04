import 'package:flutter/material.dart';

class ProjectItem extends StatelessWidget {
  final String title;
  final String date;
  final List<String> members;
  final String description;
  final double progress;
  final int comments;
  final String timeAgo;
  final bool isGradient; // true: card xanh, false: card trắng

  const ProjectItem({
    super.key,
    required this.title,
    required this.date,
    required this.members,
    required this.description,
    required this.progress,
    required this.comments,
    required this.timeAgo,
    this.isGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: isGradient ? null : Colors.white,
        gradient: isGradient
            ? const LinearGradient(
                colors: [Color.fromARGB(255, 148, 61, 255), Color(0xFF3D8BFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isGradient ? Colors.white : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.more_vert,
                color: isGradient ? Colors.white : Colors.black87,
              ),
            ],
          ),
          const SizedBox(height: 4),

          /// Date
          Text(
            date,
            style: TextStyle(
              color: isGradient ? Colors.white70 : Colors.black54,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),

          /// Avatars
          SizedBox(
            height: 36,
            child: Stack(
              children: List.generate(members.length > 3 ? 4 : members.length, (
                index,
              ) {
                if (index == 3) {
                  return Positioned(
                    left: index * 28,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: isGradient
                          ? Colors.white
                          : Colors.black87,
                      child: Text(
                        "+${members.length - 3}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isGradient ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  );
                }
                return Positioned(
                  left: index * 28,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(members[index]),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 12),

          /// Description
          Text(
            description,
            style: TextStyle(
              color: isGradient ? Colors.white : Colors.black87,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),

          /// Progress
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Progress",
                style: TextStyle(
                  color: isGradient ? Colors.white : Colors.black87,
                  fontSize: 14,
                ),
              ),
              Text(
                "${(progress * 100).toInt()}%",
                style: TextStyle(
                  color: isGradient ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: isGradient ? Colors.white24 : Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                isGradient ? Colors.white : Colors.black87,
              ),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 12),

          /// Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    color: isGradient ? Colors.white70 : Colors.black54,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "$comments",
                    style: TextStyle(
                      color: isGradient ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: isGradient ? Colors.white70 : Colors.black54,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    timeAgo,
                    style: TextStyle(
                      color: isGradient ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
