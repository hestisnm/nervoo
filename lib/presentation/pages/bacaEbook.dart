import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kelas_pintar/presentation/pages/discover_page.dart';
import 'package:kelas_pintar/presentation/pages/kumpulanebook.dart';
import 'package:kelas_pintar/presentation/pages/navbar.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class EBookReaderScreen extends StatefulWidget {
  @override
  _EBookReaderScreenState createState() => _EBookReaderScreenState();
}

class _EBookReaderScreenState extends State<EBookReaderScreen>
    with TickerProviderStateMixin {
  int currentChapter = 0;
  int currentPage = 0;
  bool showMenu = false;
  double fontSize = 16.0;
  double lineHeight = 1.6;

  late AnimationController _menuController;
  late AnimationController _pageController;
  late Animation<double> _menuAnimation;
  late Animation<Offset> _pageSlideAnimation;

  // Contoh data chapters lengkap
  List<Chapter> chapters = [
    Chapter(
      title: "Chapter 1: Introduction",
      pages: [
        BookPage(
          chapterTitle: "Chapter 1",
          pageTitle: "Welcome",
          content:
              "Welcome to this eBook reader app. This is the first page of the introduction.",
        ),
        BookPage(
          chapterTitle: "Chapter 1",
          pageTitle: "Getting Started",
          content:
              "Let's start reading! You can swipe left or right to change pages.",
        ),
      ],
    ),
    Chapter(
      title: "Chapter 2: Flutter Basics",
      pages: [
        BookPage(
          chapterTitle: "Chapter 2",
          pageTitle: "Widgets",
          content:
              "Flutter is based on widgets. Everything you see on screen is a widget.",
        ),
        BookPage(
          chapterTitle: "Chapter 2",
          pageTitle: "State Management",
          content:
              "Managing state is a crucial part of Flutter development. There are many approaches.",
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();

    _menuController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _pageController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    _menuAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _menuController,
      curve: Curves.easeInOut,
    ));

    _pageSlideAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _pageController,
      curve: Curves.easeOutCubic,
    ));

    _pageController.forward();
  }

  @override
  void dispose() {
    _menuController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (currentPage < chapters[currentChapter].pages.length - 1) {
      setState(() {
        currentPage++;
      });
      _animatePageTransition();
      HapticFeedback.lightImpact();
    } else if (currentChapter < chapters.length - 1) {
      setState(() {
        currentChapter++;
        currentPage = 0;
      });
      _animatePageTransition();
      HapticFeedback.lightImpact();
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
      _animatePageTransition();
      HapticFeedback.lightImpact();
    } else if (currentChapter > 0) {
      setState(() {
        currentChapter--;
        currentPage = chapters[currentChapter].pages.length - 1;
      });
      _animatePageTransition();
      HapticFeedback.lightImpact();
    }
  }

  void _animatePageTransition() {
    _pageController.reset();
    _pageController.forward();
  }

  void toggleMenu() {
    setState(() {
      showMenu = !showMenu;
    });

    if (showMenu) {
      _menuController.forward();
    } else {
      _menuController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentPageData = chapters[currentChapter].pages[currentPage];

    return PageWidget(
      child: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                if (showMenu) {
                  toggleMenu();
                }
              },
              onTapUp: (details) {
                if (!showMenu) {
                  final screenWidth = MediaQuery.of(context).size.width;
                  if (details.globalPosition.dx > screenWidth * 0.5) {
                    nextPage();
                  } else {
                    previousPage();
                  }
                }
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    _buildHeader(),
                    Expanded(child: _buildContent(currentPageData)),
                    _buildProgressIndicator(),
                  ],
                ),
              ),
            ),
            if (showMenu) _buildMenuOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Kumpulanebook()),
            ),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.grey[600],
                size: 18,
              ),
            ),
          ),
          Expanded(
            child: Text(
              chapters[currentChapter].title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          InkWell(
            onTap: toggleMenu,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.more_horiz,
                color: Colors.grey[600],
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BookPage page) {
    return SlideTransition(
      position: _pageSlideAnimation,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              page.chapterTitle,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[500],
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 8),
            Text(
              page.pageTitle,
              style: GoogleFonts.poppins(
                fontSize: 22,
                color: Colors.grey[800],
                fontWeight: FontWeight.w600,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 32),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  page.content,
                  style: GoogleFonts.poppins(
                    fontSize: fontSize,
                    height: lineHeight,
                    color: Colors.grey[800],
                    letterSpacing: 0.1,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    int totalPages =
        chapters.fold(0, (sum, chapter) => sum + chapter.pages.length);
    int currentPageNumber = 0;

    for (int i = 0; i < currentChapter; i++) {
      currentPageNumber += chapters[i].pages.length;
    }
    currentPageNumber += currentPage + 1;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(1),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: currentPageNumber / totalPages,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Text(
            '$currentPageNumber of $totalPages',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOverlay() {
    return FadeTransition(
      opacity: _menuAnimation,
      child: Container(
        color: Colors.black.withOpacity(0.3),
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Reading Settings',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 24),
                _buildSliderSetting(
                  'Font Size',
                  fontSize,
                  12.0,
                  24.0,
                  (value) => setState(() => fontSize = value),
                  '${fontSize.toInt()}px',
                ),
                SizedBox(height: 16),
                _buildSliderSetting(
                  'Line Height',
                  lineHeight,
                  1.2,
                  2.0,
                  (value) => setState(() => lineHeight = value),
                  lineHeight.toStringAsFixed(1),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: toggleMenu,
                  child: Text(
                    'Close',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSliderSetting(String label, double value, double min, double max,
      ValueChanged<double> onChanged, String valueLabel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: value,
                min: min,
                max: max,
                onChanged: onChanged,
                activeColor: Colors.blue,
                inactiveColor: Colors.grey[300],
              ),
            ),
            SizedBox(width: 8),
            Text(
              valueLabel,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Chapter {
  final String title;
  final List<BookPage> pages;

  Chapter({required this.title, required this.pages});
}

class BookPage {
  final String chapterTitle;
  final String pageTitle;
  final String content;

  BookPage({
    required this.chapterTitle,
    required this.pageTitle,
    required this.content,
  });
}
