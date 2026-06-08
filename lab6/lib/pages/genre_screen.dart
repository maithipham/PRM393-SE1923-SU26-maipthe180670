import 'package:flutter/material.dart';
import 'package:diacritic/diacritic.dart';
import '../models/movie.dart';
import '../widgets/movie_header.dart';
import '../widgets/movie_search.dart';
import '../widgets/genre_chips.dart';
import '../widgets/movie_card.dart';
import '../widgets/movie_sort.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  // Các biến quản lý bộ lọc State của ứng dụng
  String _searchQuery = '';
  String _selectedGenre = 'All';
  String _selectedSort = 'A-Z';

  @override
  Widget build(BuildContext context) {
    // Kiếm tra kích thước màn hình tổng thể bằng MediaQuery (Để căn chỉnh padding hệ thống)
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding = screenWidth > 800 ? 32.0 : 16.0;

    // ==========================================
    // LOGIC FILTER & SORT MOVIE LIST
    // ==========================================
    List<Movie> visibleMovies = allMovies.where((movie) {
      // 1. Lọc theo thanh tìm kiếm (Không phân biệt hoa thường)
      final bool matchesSearch = removeDiacritics(movie.title.toLowerCase())
          .contains(removeDiacritics(_searchQuery.toLowerCase()));
      // 2. Lọc theo Genre Chip đang chọn
      final bool matchesGenre = _selectedGenre == 'All' || movie.genres.contains(_selectedGenre);
      return matchesSearch && matchesGenre;
    }).toList();

    // 3. Tiến hành sắp xếp danh sách phim theo Dropdown được chọn
    if (_selectedSort == 'A-Z') {
      visibleMovies.sort((a, b) => removeDiacritics(a.title.toLowerCase())
          .compareTo(removeDiacritics(b.title.toLowerCase())));
    } else if (_selectedSort == 'Z-A') {
      visibleMovies.sort((a, b) => removeDiacritics(b.title.toLowerCase())
          .compareTo(removeDiacritics(a.title.toLowerCase())));
    } else if (_selectedSort == 'Year') {
      visibleMovies.sort((a, b) => b.year.compareTo(a.year)); // Phim mới nhất lên đầu
    } else if (_selectedSort == 'Rating') {
      visibleMovies.sort((a, b) => b.rating.compareTo(a.rating)); // Điểm cao nhất lên đầu
    }


// --- Kiểm tra điều kiện hiện nút Clear Filters ---
    final bool hasFilter = _searchQuery.isNotEmpty || _selectedGenre != 'All' || _selectedSort != 'A-Z';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Khối Header
              MovieHeader(selectedGenre: _selectedGenre),
              const SizedBox(height: 20),

              // 2. Khối Tìm kiếm (Nhận kết quả gõ truyền ngược ra State)
              MovieSearchBar(onChanged: (value) => setState(() => _searchQuery = value)),
              const SizedBox(height: 16),

              // 3. Khối Chips Danh mục
              GenreChips(
                availableGenres: availableGenres,
                selectedGenre: _selectedGenre,
                onGenreSelected: (genre) => setState(() => _selectedGenre = genre),
              ),
              const SizedBox(height: 16),

              // 4. Khối Sắp xếp & Nút Reset
              SortBar(
                selectedSort: _selectedSort,
                showClearButton: hasFilter,
                onSortChanged: (newValue) {
                  if (newValue != null) setState(() => _selectedSort = newValue);
                },
                onClearPressed: () => setState(() {
                  _searchQuery = '';
                  _selectedGenre = 'All';
                  _selectedSort = 'A-Z';
                }),
              ),
              const SizedBox(height: 12),

              // 5. Khối hiển thị Danh sách Phim Responsive
              Expanded(
                child: visibleMovies.isEmpty
                    ? const Center(
                  child: Text(
                    'No movies found matching the criteria.',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                )
                    : LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth >= 800) {
                      return GridView.builder(
                        itemCount: visibleMovies.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 2.3,
                        ),
                        itemBuilder: (context, index) => MovieCard(movie: visibleMovies[index], isTablet: true),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: visibleMovies.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: MovieCard(movie: visibleMovies[index], isTablet: false),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}