import 'package:flutter/material.dart';
import 'package:listly/data/elemento.dart';
import 'package:listly/data/lista.dart';
import 'package:listly/theme/app_color.dart';
import 'package:listly/theme/app_sizer.dart';

class ElementosPage extends StatefulWidget{

  ElementosPage({super.key});
  
  @override
  State<ElementosPage> createState() => _ElementosPageState();  
}

class _ElementosPageState extends State<ElementosPage>{
  
  Lista? _lista;
  List<Elemento> _elementos = [];

  @override
  void initState() {
    super.initState();
    //this._lista;
    //this._elementos = this._lista.elementos;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context), 
          icon: const Icon(Icons.arrow_back))
      ),
      body: Column(
        children: [
          Expanded(
            child: ReorderableListView(
              padding: const EdgeInsets.all(AppSizes.paddingListaView),
              onReorderItem: (oldIndex, newIndex) {
                setState(() {
                  final Elemento elemento = this._elementos.removeAt(oldIndex);
                  this._elementos.insert(newIndex, elemento);
                });
              },
              children: this._elementos.map((elemento) => _ElememtoCard(
                key: ValueKey(elemento.id),
                elemento: elemento
                )).toList(),
            ),
          ),
          
        ],
      ),
    );

  }
  
}

class _ElememtoCard extends StatelessWidget{

  final Elemento _elemento;

  const _ElememtoCard({super.key, required this._elemento});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingCard),
        child: Row(
          children: [
            Container(
              width: AppSizes.sizeStackIconLista,
              height: AppSizes.sizeStackIconLista,
              decoration: BoxDecoration(
                color: AppColor.colorIconLista,
                borderRadius: BorderRadius.circular(AppSizes.radioIconLista),
              ),
              alignment: Alignment.center,
              child: Text(this._elemento.emoji, textScaler: TextScaler.linear(AppSizes.scalarIconLista)),
            ), 

            const SizedBox(width: AppSizes.widthCardSizeBoxRow),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (this._elemento.tachado)
                    Text(
                      this._elemento.nombre, 
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ),
                    )
                  else
                    Text(
                      this._elemento.nombre, 
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),                   
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
  
}