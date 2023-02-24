import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math show Random;

void main() {
  runApp(const MyApp());
}

const countries = ['Ghana', 'Gambia', 'Togo'];

extension RandomElement<T> on Iterable<T>{
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

class CountriesCubit extends Cubit<String?> {
  CountriesCubit() :super(null);

  void getCountry() => emit(countries.getRandomElement());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My App',
      home: ProjectIntro(),
    );
  }
}


class ProjectIntro extends StatefulWidget {
  const ProjectIntro({Key? key}) : super(key: key);

  @override
  State<ProjectIntro> createState() => _ProjectIntroState();
}

class _ProjectIntroState extends State<ProjectIntro> {
  late final CountriesCubit countriesCubit;

  @override
  void initState() {
    super.initState();
    countriesCubit = CountriesCubit();
  }
  @override
  void dispose() {
    countriesCubit.close();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Project Introduction'),
        ),
        body: Center(
            child: StreamBuilder<String?>(
              stream: countriesCubit.stream,
              builder: (context, snapshot) {
                final button = TextButton(
                    onPressed: () => countriesCubit.getCountry(),
                    child: const Text('Get your Lucky Country'));
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(child: button);
                  case ConnectionState.waiting:
                    return Center(child: button);
                  case ConnectionState.active:
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(snapshot.data ?? ''),
                          button,
                        ],
                      ),
                    );
                  case ConnectionState.done:
                    return const SizedBox();
                }
              },
            )
        )

    );
  }
}
