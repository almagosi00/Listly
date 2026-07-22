import 'package:flutter/material.dart';
import 'package:listly/data/lista.dart';
import 'package:listly/mock_data.dart';
import 'package:listly/theme/app_color.dart';
import 'package:listly/theme/app_sizer.dart';

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
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.tituloPage),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.paddingBuscador),
            child: Text('Aquí irá el buscador'), // de momento, un placeholder
          ),
          Expanded(child: ListView(
            padding: const EdgeInsets.all(AppSizes.paddingListaView),
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
        padding: const EdgeInsets.all(AppSizes.paddingCard),
        child: Row(
          children: [

            this._iconLista(),

            const SizedBox(width: AppSizes.widthCardSizeBoxRow),

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
          width: AppSizes.sizeStackIconLista,
          height: AppSizes.sizeStackIconLista,
          decoration: BoxDecoration(
            color: AppColor.colorIconLista,
            borderRadius: BorderRadius.circular(AppSizes.radioIconLista),
          ),
          alignment: Alignment.center,
          child: Text(this._lista.emoji, textScaler: TextScaler.linear(AppSizes.scalarIconLista)),
        ),        
        
        if (this._lista.compartida)
          Positioned(
            bottom: AppSizes.bottomIconListaShare,
            right: AppSizes.rightIconListaShare,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.colorIconListaShare,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.share,
                size: AppSizes.sizeIconListaShare,
              ),
            ),
          )
      ],
    );
  }

}