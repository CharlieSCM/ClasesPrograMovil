
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:login/assets/global_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    //PROBAR CAMBIO EN EL TITULO DE LA PANTALLA
    return ValueListenableBuilder(
      valueListenable: GlobalValues.flagTitle,
      builder: (context, value, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('Bienvenidos :)')),
          drawer: createDrawer(context),
        );
      }
    );
  }


  final imgLogo = Container(
      width: 300,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://cdn-icons-png.flaticon.com/512/2919/2919600.png')),
      ),
    );

  Widget createDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/400'),
            ),
            accountName: Text('CharlChief'),
            accountEmail: Text('salazar.charlie2000@gmail.com'),
          ),
          ListTile(
            leading: Image.asset('assets/fresa.png'),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Instituto Tecnologico de Celaya'),
            subtitle: const Text('Acerca de...'),
            onTap: () {
              //Navigator.pushNamed(context, '/item');
            },
          ),
          ListTile(
            leading: Icon(Icons.task_alt_outlined),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Administrador Carreras'),
            onTap: () {
              Navigator.pushNamed(context, '/carrera');
            },
          ),
        
          ListTile(
            leading: Icon(Icons.task_alt_outlined),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Administrador Profesores'),
            onTap: () {
              Navigator.pushNamed(context, '/profe');
            },
          ),
            ListTile(
            leading: Icon(Icons.task_alt_outlined),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Administrador Tareas'),
            onTap: () {
              Navigator.pushNamed(context, '/task');
            },
          ),
          
          ListTile(
            leading: Icon(Icons.task_alt_outlined),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Calendario'),
            onTap: () {
              Navigator.pushNamed(context, '/calendar');
            },
          ),
          ListTile(
            leading: Icon(Icons.task_alt_outlined),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Movies'),
            onTap: () {
              Navigator.pushNamed(context, '/popular');
            },
          ),
          ListTile(
            leading: Icon(Icons.task_alt_outlined),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Test Provider'),
            onTap: () {
              Navigator.pushNamed(context, '/prov');
            },
          ),
          const Spacer(
            flex: 1,
          ),
          DayNightSwitcher(
            isDarkModeEnabled: GlobalValues.flagTheme.value,
            onStateChanged: (isDarkModeEnabled) async {
              GlobalValues.flagTheme.value = isDarkModeEnabled;
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('darkTheme', isDarkModeEnabled);
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.task_alt_outlined),
            title: const Text('Cerrar sesion'),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLogged', false);
              Navigator.pushNamed(context, '/dash_log');
            },
          ),
          ListTile(
            leading: Icon(Icons.task_alt_outlined),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Hollow'),
            onTap: () {
              Navigator.pushNamed(context, '/hollow');
            },
          ),
          
        ],
        
      ),
      
    );
    
  }
}

  /*void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('sessionSaved');
    Navigator.pushReplacementNamed(context, '/dash_log');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Bienvenidos :)'),
      ),
      drawer: createDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget createDrawer(){
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: 
              NetworkImage('https://i.pravatar.cc/400'),
            ),
            accountName: Text('Chalchief'), 
            accountEmail: Text('salazar.charlie2000@gmail.com')
            ),
            ListTile(
              //leading: Image.network('https://cdn-icons-png.flaticon.com/128/1625/1625048.png'),
              leading: Image.asset('assets/fresa.png'),
              trailing:  Icon(Icons.chevron_right),
              title: Text('furitApp'),
              subtitle: Text('Carrucel'),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.task_alt_outlined),
              trailing: Icon(Icons.chevron_right),
              title: Text('Task Manager'),
              onTap: () => Navigator.pushNamed(context, '/task'),
            ),
            ListTile(
            leading: Icon(Icons.task_alt_outlined),
            trailing: Icon(Icons.chevron_right),
            title: Text('Movies'),
            onTap: () => Navigator.pushNamed(context, '/popular'), 
          ),
          ListTile(
            leading: Icon(Icons.task_alt_outlined),
            trailing: Icon(Icons.chevron_right),
            title: Text('Test Provider'),
            onTap: () => Navigator.pushNamed(context, '/prov'), 
          ),
            DayNightSwitcher(
              isDarkModeEnabled: GlobalValues.flagTheme.value,
              onStateChanged: (isDarkModeEnabled) {
                GlobalValues.flagTheme.value = isDarkModeEnabled;
                GlobalValues().guardarValor(isDarkModeEnabled);
              },
            ),

          ListTile(
            leading: Icon(
                Icons.logout 
                ),
            title: Text('Cerrar sesión'),
            onTap: () {
              logout();
            },
          )
        ],
      ),
    );
  }
}*/