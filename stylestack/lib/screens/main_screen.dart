import 'package:flutter/material.dart';
import '../screens/products_screen.dart';
import '../screens/Favorite_screen.dart';
import '../screens/home_screen.dart';
import '../widgets/outfit_widget.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  // Lista de pantallas para navegar
  final List<Widget> _pages = [ HomeScreen(), Favorite_Screen(),ProductsScreen()];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 20, 45),

      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 110),
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                children: _pages,
              ),
            ),
        ),

          Positioned(
            left: 10,
            right: 10,
            bottom: 15,
            child: const OutfitWidget(),
          ),
       
          
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favoritos"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Sugerencias"),

        ],
      ),

      
    );
  }
}