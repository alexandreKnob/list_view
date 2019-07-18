import 'package:flutter/material.dart';

import 'clientes.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Cliente {
  String nome;
  int idade;

  Cliente(this.nome, this.idade);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Cliente> clientes = List();

  String _selectedValue = "";
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();

  @override
  void initState() {
    super.initState();


    clientes.add(Cliente("Marcelo", 30));
    clientes.add(Cliente("João", 20));
    for (Cliente p in clientes) {
      print(p.nome + p.idade.toString());
    }
    _selectedValue = "20";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _montaMenu(),
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text("Teste de Listas"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(7.0),
        child: Column(
          children: <Widget>[
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(1.0),
              itemCount: clientes.length,
              itemBuilder: (BuildContext context, int index) {
                return _montaItem(context, index);
              },
            ),
            Divider(
              height: 40.0,
            ),
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(

                    child: Container(
                      padding: EdgeInsets.only(top:10.0),
                      child: Text("Cadastro de Clientes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: TextField(
                      controller: _nomeController,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          labelText: "Nome",
                          focusedBorder: OutlineInputBorder()),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: TextField(
                      controller: _idadeController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          labelText: "Idade",
                          focusedBorder: OutlineInputBorder()),
                    ),
                  )
                ],
              ),
            ),
            FlatButton(
              textColor: Colors.white,
              color: Colors.blueAccent,
              child: Text("adicionar"),
              onPressed: () {
                setState(() {
                  bool jaTem = false;
                  for (Cliente p in clientes) {
                    /// percorre  a lista e verifica se ja tem esse cliente
                    if (p.nome == _nomeController.text) {
                      jaTem = true;
                    }
                  }
                  if (jaTem == false) {
                    clientes.add(Cliente(_nomeController.text,
                        int.parse(_idadeController.text)));
                  } else {
                    _alerta();
                  }
                });
              },
            ),
            DropdownButton<String>(

              value:  _selectedValue,
              isExpanded: true,

              items: clientes
                  .map((data) => DropdownMenuItem<String>(
                child: Text(data.nome),
                value: data.idade.toString(),
              ))
                  .toList(),
              onChanged: (String value) {
                setState(() => _selectedValue = value);
              },

            ),Text(_selectedValue),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.indigoAccent,
        child: Container(
          height: 105,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.build),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _montaItem(BuildContext context, index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedValue = clientes[index].idade.toString();
        });

        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Alteração de Dados do Cliente "),
              content: SingleChildScrollView(
                  child: ListBody(
                children: <Widget>[
                  Text("Nome  : " + clientes[index].nome ),
                  Text("Idade : " + clientes[index].idade.toString() ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: TextField(
                      controller: _nomeController,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          labelText: "Nome",
                          focusedBorder: OutlineInputBorder()),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: TextField(
                      controller: _idadeController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          labelText: "Idade",
                          focusedBorder: OutlineInputBorder()),
                    ),
                  )
                ],
              )),
              actions: <Widget>[
                FlatButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Gravar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      clientes.setAll(index,[Cliente(_nomeController.text,int.parse(_idadeController.text))]);
                      _nomeController.text="";
                      _idadeController.text="";
                    });
                  },
                ),
              ],
            );
          },
        );
      },
      child: Card( // Lista os clientes
          child: ListTile(
            leading: Icon(Icons.person,size: 50,color: Colors.blue,),
            title: Text(clientes[index].nome, style: TextStyle(fontSize: 25)),
            subtitle: Text(clientes[index].idade.toString(),style: TextStyle(fontSize: 20)),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Colors.redAccent,
              onPressed: () {
               _confirmaExclusao(context, index);
             },
        ),
      )),
    );
  }

  _alerta() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Atenção !"),
          content: Text(
            "Nome já Cadastrado ! ",
            style: TextStyle(color: Colors.red),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _montaMenu() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "A",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
            accountName: Text("Alexandre Knob"),
            accountEmail: Text("alexandre@gmail.com"),
            onDetailsPressed: () {
              Text("teste");
            },
          ),
          ListTile(
            title: Text("Clientes"),
            leading: Icon(Icons.account_balance),
            subtitle: Text("Os melhores Clientes"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Clientes()));
            },
          ),
          ListTile(
            title: Text("Produtos"),
            subtitle: Text("Produtos diferenciados"),
            leading: Icon(Icons.email),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Serviços"),
          ),
          ListTile(
            title: Text("Contato"),
          ),
        ],
      ),
    );
  }

  _confirmaExclusao(BuildContext context, index) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Nome : " + clientes[index].nome),
          content:
              Text("Confirma a exclusão do " + clientes[index].nome + " ?"),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  clientes.removeAt(index);
                });
              },
            ),
          ],
        );
      },
    );
  }
}
