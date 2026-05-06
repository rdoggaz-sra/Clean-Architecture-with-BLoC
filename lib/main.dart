import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart' as di;

import 'features/notes/presentation/bloc/note_bloc.dart';
import 'features/categories/presentation/bloc/category_bloc.dart';
import 'features/categories/presentation/bloc/category_event.dart';

import 'features/categories/presentation/pages/categories_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<NoteBloc>()),
        BlocProvider(
          create: (_) => di.sl<CategoryBloc>()..add(LoadCategories()),
        ),
      ],
      child: const MaterialApp(
        home: CategoriesPage(),
      ),
    );
  }
}