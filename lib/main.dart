import 'package:flutter/material.dart';
import 'core/api_service.dart';
import 'features/product_details/data/repository/product_repo.dart';
import 'features/product_details/screens/product_details_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ApiService>(
          create: (_) => ApiService(),
        ),
        RepositoryProvider<ProductRepository>(
          create: (context) => ProductRepository(
            context.read<ApiService>(),
          ),
        ),
      ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Inter',
            textTheme: const TextTheme(
              displayLarge: TextStyle(fontWeight: FontWeight.w400), // Regular
              displayMedium: TextStyle(fontWeight: FontWeight.w500), // Medium
              displaySmall: TextStyle(fontWeight: FontWeight.w700), // Bold
              headlineLarge: TextStyle(fontWeight: FontWeight.w700),
              headlineMedium: TextStyle(fontWeight: FontWeight.w500),
              headlineSmall: TextStyle(fontWeight: FontWeight.w400),
              bodyLarge: TextStyle(fontWeight: FontWeight.w400),
              bodyMedium: TextStyle(fontWeight: FontWeight.w500),
              bodySmall: TextStyle(fontWeight: FontWeight.w400),
              labelLarge: TextStyle(fontWeight: FontWeight.w500),
              labelSmall: TextStyle(fontWeight: FontWeight.w400),
            ),
            primaryColor: const Color(0xFFFE7E00),
          ),
          home: ProductDetailsScreen(productId: 6),
        ),

    );
  }
}
