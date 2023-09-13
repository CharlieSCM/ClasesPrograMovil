
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:login/assets/global_values.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

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
            DayNightSwitcher(
              isDarkModeEnabled: GlobalValues.flagTheme.value,
              onStateChanged: (isDarkModeEnabled) {
              setState(() {
                GlobalValues.flagTheme.value = isDarkModeEnabled;
              });
            },
          ),
        ],
      ),
    );
  }
}