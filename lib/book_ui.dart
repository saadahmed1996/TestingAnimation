class Book {
  const Book({
    required this.title,
    required this.author,
    required this.image,
  });
  final String title;
  final String author;
  final String image;
}

const _bookAppAsset = 'assets/images';
final bookAppBackground = '$_bookAppAsset/background.png';

final books = const [
  Book(
    title: 'Wink Poppy Midnight',
    author: 'April Genevia',
    image: '$_bookAppAsset/book1.jpg',
  ),
  Book(
    title: 'Walking with miss ',
    author: 'Tamara Chantala Chutiya',
    image: '$_bookAppAsset/book2.jpg',
  ),
  Book(
    title: 'ABC Book',
    author: 'John Shlby',
    image: '$_bookAppAsset/book3.jpg',
  ),
  Book(
    title: 'Once upon a time',
    author: 'Papi Chullo',
    image: '$_bookAppAsset/book4.jpg',
  ),
  Book(
    title: 'Hawa ki basti',
    author: 'Dasti Maiya Dasti',
    image: '$_bookAppAsset/book5.jpg',
  ),
];
