import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:secure_chat/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:secure_chat/features/auth/presentation/pages/auth_gate.dart';
import 'package:secure_chat/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final authBloc = GetIt.instance<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => authBloc)],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: AuthGate(),
      ),
    );
  }
}
