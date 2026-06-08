class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  const Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

const List<Movie> allMovies = [
  Movie(
    title: 'Mai',
    year: 2024,
    genres: ['Drama', 'Romance'],
    posterUrl: 'https://tse2.mm.bing.net/th/id/OIP.k8gr7963d9uQR9B47omQxQHaOG?cb=thfvnextfalcon2&pid=ImgDet&w=181&h=345&c=7&dpr=1.6&o=7&rm=3',
    rating: 8.5,
  ),
  Movie(
    title: 'Lật Mặt 7: Một Điều Ước',
    year: 2024,
    genres: ['Comedy', 'Family', 'Drama'],
    posterUrl: 'https://tse4.mm.bing.net/th/id/OIP.edIfvsktA0OPHenjEF_JSwHaJQ?cb=thfvnextfalcon2&pid=ImgDet&w=204&h=255&c=7&dpr=1.6&o=7&rm=3',
    rating: 8.8,
  ),
  Movie(
      title: 'Đất Rừng Phương Nam',
      year: 2023,
      genres: ['Action', 'History', 'Drama'],
      posterUrl: 'https://tse1.mm.bing.net/th/id/OIP.r83KoPvD5xjPHDHwdBvowwHaK8?cb=thfvnextfalcon2&pid=ImgDet&w=204&h=301&c=7&dpr=1.6&o=7&rm=3',
      rating: 8.2
  ),
  Movie(
    title: 'Bố Già',
    year: 2021,
    genres: ['Drama', 'Family'],
    posterUrl: 'https://m.media-amazon.com/images/M/MV5BNWE2MWRiMmYtMDE1Zi00ZTA4LTgxMDQtNGI3MDdiNWU3YjM2XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
    rating: 8.7,
  ),
  Movie(
    title: 'Hai Phượng',
    year: 2019,
    genres: ['Action', 'Thriller'],
    posterUrl: 'https://th.bing.com/th/id/R.bcbb1b9b059d7ea800fcbb98cefff737?rik=y9xn69Kqbk6UYw&riu=http%3a%2f%2fwww.impawards.com%2fintl%2fvietnam%2f2019%2fposters%2fhai_phuong_ver2_xxlg.jpg&ehk=trplNSWzBhi0PX9MIWwzdYQAqrVtIi7WD7DzYS%2fFf5M%3d&risl=&pid=ImgRaw&r=0',
    rating: 8.9,
  ),
  Movie(
    title: 'Em Chưa 18',
    year: 2017,
    genres: ['Comedy', 'Romance'],
    posterUrl: 'https://thfvnext.bing.com/th/id/OIP.C5KKadQOp3jptJqZHb7jVgHaLH?w=192&h=288&c=7&r=0&o=7&cb=thfvnextfalcon2&dpr=1.6&pid=1.7&rm=3',
    rating: 7.9,
  ),

];

// Danh sách nút bấm Thể loại bằng Tiếng Anh (Mặc định ban đầu là 'All')
const List<String> availableGenres = [
  'All',
  'Action',
  'Drama',
  'Romance',
  'Comedy',
  'Family',
  'Thriller'
];