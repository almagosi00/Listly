import 'package:flutter/material.dart';
import 'package:listly/data/lista.dart';
import 'package:listly/mock_data.dart';

class ListasPage extends StatefulWidget{
  final String tituloPage;
  const ListasPage({super.key, required this.tituloPage});
  
  @override
  State<ListasPage> createState() => _ListaPageState();
}

class _ListaPageState extends State<ListasPage>{

  List<Lista> _listas = [];

  @override
  void initState() {
    super.initState();
    this._listas = mockData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.tituloPage),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Aquí irá el buscador'), // de momento, un placeholder
          ),
          Expanded(child: ListView(
            padding: const EdgeInsets.all(16),
            children:
              this._listas.map((lista) => _ListaCard(lista: lista)).toList(),
          ))
        ],
      )
    );
  }
  
}


class _ListaCard extends StatelessWidget{

  final Lista _lista;

  const _ListaCard({super.key, required this._lista});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [

            this._iconLista(),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this._lista.nombre, 
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                      ),
                    ),
                  this._subText(),
                ],
              ),
            ),

            const Icon(
              Icons.more_vert
            )

          ],
        ),
      ),
    );
  }
  
  Text _subText(){
    if(this._lista.compartida){
      return Text(" ${this._lista.numElementos} elementos - ${this._lista.numPersonas} personas");
    }
    else{
      return Text(" ${this._lista.numElementos} elementos");
    }
  }

  Stack _iconLista(){
    return Stack(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFE4EAE1),
            borderRadius: BorderRadius.circular(11),
          ),
          alignment: Alignment.center,
          child: Text(this._lista.emoji, textScaler: TextScaler.linear(1.5)),
        ),        
        
        if (this._lista.compartida)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.share,
                size: 16,
              ),
            ),
          )
      ],
    );
  }

}