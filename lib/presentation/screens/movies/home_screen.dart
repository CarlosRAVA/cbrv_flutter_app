import 'package:cbrv_movies_app/presentation/views/movies/home_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomeView());
  }
}