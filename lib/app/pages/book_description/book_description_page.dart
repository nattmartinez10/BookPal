import 'package:bookpal/app/widgets/book_description/borrow_button.dart';
import 'package:bookpal/app/widgets/book_description/ratings_row.dart';
import 'package:bookpal/app/widgets/loading/basic_shimmer.dart';
import 'package:bookpal/app/widgets/loading/shimmer_image.dart';
import 'package:bookpal/core/constants/constants.dart';
import 'package:bookpal/core/util/utilities.dart';
import 'package:bookpal/data/models/physical_book_model.dart';
import 'package:flutter/material.dart';

class BookDescription extends StatelessWidget {
  const BookDescription({super.key, required this.book, this.scanned = false});

  final PhysicalBookModel book;
  final bool scanned;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      floatingActionButton: (scanned)
          ? BorrowButton(
              book: book)
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.chevron_left,
            size: 32,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        title: Text(
          'Book description',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FutureBuilder(
                    future: Utilities.getDownloadUrl(
                        '$booksCoversPath${book.bookCover}'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _buildBookCover(const ThemeShimmer());
                      } else if (snapshot.hasError) {
                        return _buildBookCover(const Icon(Icons.error_outline));
                      }
                      return _buildBookCover(ShimmerImage(url: snapshot.data!));
                    },
                  ),
                  Expanded(
                    child: Container(
                      width: 200,
                      height: 300,
                      margin: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            book.title,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            child: Text(
                              'By ${book.author}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          RatingsRow(book: book),
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            child: Text(
                              '${book.available!} book${(book.available! > 1) ? 's' : ''} in library',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildBookCover(Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        width: 140,
        height: 200,
        child: child,
      ),
    );
  }
}
