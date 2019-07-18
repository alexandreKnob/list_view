import 'package:flutter/material.dart';
import 'produtos.dart';


class Clientes extends StatefulWidget {
  @override
  _ClientesState createState() => _ClientesState();
}


class _ClientesState extends State<Clientes> {

  int _selectedIndex=0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    //Navigator.pop(context);
    Navigator.push(context,MaterialPageRoute(builder: (context) => Produtos()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text("Clientes"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.account_balance),
              onPressed: () {}),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(_selectedIndex.toString()),
          )

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),

    );
  }
}
