import 'package:fakestore/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:fakestore/screens/screens.dart';
import 'package:provider/provider.dart';

/**
 * La classe `AppState` i `MyApp` configuren l'estat global de l'aplicació i la seva estructura bàsica de navegació.
 *
 * Components principals:
 *
 * 1. **Classe `AppState`**:
 *    - És la classe que envolta l'aplicació amb un proveïdor d'estat, proporcionant accés al `ProductsProvider` a tota l'aplicació.
 *    - Utilitza `MultiProvider` per proporcionar el `ProductsProvider`, que és responsable de gestionar l'estat dels productes (com obtenir dades de productes, gestionar el carregament, etc.).
 *    - L'opció `lazy: false` assegura que el proveïdor es crea immediatament quan s'inicia l'aplicació, evitant així retards en la càrrega de dades de productes.
 *
 * 2. **Classe `MyApp`**:
 *    - Configura la configuració bàsica de l'aplicació, inclòs el tema (un tema clar amb un `AppBar` de color morat) i les rutes de navegació.
 *    - Definim dues rutes: la ruta inicial és la `home`, que carrega la pantalla principal (`HomeScreen`), i la ruta `details`, que carrega la pantalla de detalls (`DetailsScreen`).
 *    - El `MaterialApp` és el widget principal que conté tota l'estructura de la nostra aplicació, incloent el títol, les rutes i el tema.
 *
 * 3. **Configuració de rutes**:
 *    - Quan un usuari navega a `home`, es carrega la `HomeScreen`, que és la pantalla inicial que mostra la llista de productes.
 *    - Quan un usuari navega a `details`, es carrega la `DetailsScreen`, que mostra els detalls d'un producte específic.
 *
 * 4. **Tema**:
 *    - S'ha configurat un tema clar (`ThemeData.light()`) amb una personalització de l'`AppBar` per fer-lo de color morat.
 *    - Aquest tema s'aplica a totes les pantalles de l'aplicació, proporcionant una estètica consistent.
 *
 * Funcionalitats destacades:
 * - Utilització de `ChangeNotifierProvider` per gestionar l'estat global de l'aplicació, en aquest cas, la llista de productes.
 * - Configuració d'una aplicació Material amb un tema personalitzat i rutes per gestionar la navegació entre pantalles.
 * - Creació d'un sistema de navegació senzill amb dues pantalles: `HomeScreen` per mostrar la llista de productes i `DetailsScreen` per mostrar els detalls d'un producte.
 */

void main() => runApp(AppState());

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
          lazy: false,
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fakestore',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomeScreen(),
        'details': (BuildContext context) => DetailsScreen(),
      },
      theme: ThemeData.light()
          .copyWith(appBarTheme: const AppBarTheme(color: Colors.purple)),
    );
  }
}
