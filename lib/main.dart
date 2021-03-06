import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:mascotas_app/bloc/bloc.dart';
import 'package:mascotas_app/providers/providers.dart';
import 'package:mascotas_app/repositories/repository.dart';
import 'package:mascotas_app/screens/screens.dart';
import 'package:mascotas_app/theme/style.dart';
import 'package:mascotas_app/widgets/widgets.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
        ..maxConnectionsPerHost = 50;
  }
}

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  // Soluciona error de carga de NetworkImages
  // limitando las peticiones simultáneas
  /* HttpOverrides.global = MyHttpOverrides(); */

  HydratedBloc.storage = await HydratedStorage.build();

  runApp(App());
}

class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AlertsBloc(
            repository: AlertsRepository()
          ),
        ),
        BlocProvider(
          create: (context) => FavoriteBloc(),
        ),
        /* BlocProvider(
          create: (context) => FiltrosBloc(
            establecimientosBloc: BlocProvider.of<EstablecimientosBloc>(context),
            favoriteBloc: BlocProvider.of<FavoriteBloc>(context)
          ),
        ), */
        BlocProvider(
          create: (context) => ConfiguracionBloc(),
        ),
        BlocProvider(
          create: (context) => AutenticacionBloc(
            repository: UsuarioRepository()
          ),
        ),
      ],
      child: BlocBuilder<ConfiguracionBloc, ConfiguracionState>(
        builder: (context, state) {
          if (state is ConfiguracionInitial) {
            BlocProvider.of<ConfiguracionBloc>(context).add(FetchConfiguracion());
          }

          if (state is ConfiguracionSuccess)
            return GraphQLProvider(
            client: ValueNotifier(BaseProvider.initailizeClient()),
            child: MaterialApp(
              title: 'Mascotas',
              /* builder: (context, child) {
                return Scaffold(
                  drawer: DrawerWidget(), 
                  body: child,
                );
              }, */
              debugShowCheckedModeBanner: false,
              themeMode: state.config['dark-mode'] ? ThemeMode.dark : ThemeMode.light,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              /* home: RootScreen(), */
              initialRoute: '/',
              routes: <String, WidgetBuilder>{
                '/': (BuildContext context) => RootScreen(),
                '/filtros': (BuildContext context) => FiltrosScreen()
              },
            )
          );
        }
      )
    );
  }
}
