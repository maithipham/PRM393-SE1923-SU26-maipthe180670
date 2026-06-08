import 'package:flutter/material.dart';
import '../models/movie.dart'; // Đảm bảo import đúng cấu trúc file Movie của bạn

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool isTablet;

  const MovieCard({
    super.key,
    required this.movie,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    final double posterWidth = isTablet ? 110 : 85;

    return Container(
      height: 130, // Khống chế chiều cao cố định tránh tràn Layout
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F2C),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      clipBehavior: Clip.antiAlias, // Bo tròn ảnh khớp với viền Card
      child: Row(
        children: [
          // 1. Hình ảnh poster phim
          SizedBox(
            width: posterWidth,
            height: double.infinity,
            child: Image.network(
              movie.posterUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey,
                  child: const Icon(Icons.movie, color: Colors.white, size: 30),
                );
              },
            ),
          ),

          // 2. Nội dung chi tiết phim
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Year: ${movie.year}',
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  // List tags thể loại nằm ngang
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: movie.genres.map((g) {
                        return Container(
                          margin: const EdgeInsets.only(right: 6),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.deepPurple.withOpacity(0.5)),
                          ),
                          child: Text(
                            g,
                            style: const TextStyle(color: Colors.purpleAccent, fontSize: 11),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 3. Khối hiển thị điểm đánh giá (Sao vàng)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(height: 4),
                Text(
                  movie.rating.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}