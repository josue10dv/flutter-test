import 'package:go_router/go_router.dart';

import 'pages/ticket_page.dart';
import 'pages/home_page.dart';
import 'pages/food_page.dart';
import 'pages/slide_page.dart';
import 'pages/spent_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomePage()),
    GoRoute(path: '/ticket', builder: (_, __) => const TicketPage()),
    GoRoute(path: '/food', builder: (_, __) => const FoodPage()),
    GoRoute(path: '/slide', builder: (_, __) => const SlidePage()),
    GoRoute(path: '/spent', builder: (_, __) => const SpentPage()),
  ],
);
