import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listly/data/elemento.dart';
import 'package:listly/data/lista.dart';
import 'package:listly/notifier/listas_notifier.dart';
import 'package:listly/theme/app_color.dart';
import 'package:listly/theme/app_sizer.dart';

class ElementosPage extends ConsumerStatefulWidget{

  int idLista;

  ElementosPage({super.key, required this.idLista});
  
  @override
  ConsumerState<ElementosPage> createState() => _ElementosPageState();  
}

class _ElementosPageState extends ConsumerState<ElementosPage>{
  
  late Lista _lista;
  late List<Elemento> _elementos;

  @override
  Widget build(BuildContext context) {

    this._lista = ref.watch(listasProvider)[widget.idLista]!;
    this._elementos = this._lista.elementos;

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
                ref.read(listasProvider.notifier).cambiarOrdenElementos(
                  idLista: widget.idLista, 
                  idElemento: this._elementos[oldIndex].id, 
                  nuevoOrden: newIndex
                );
                if (oldIndex < newIndex){
                  for ( int i = oldIndex+1; i <= newIndex; i++){
                    ref.read(listasProvider.notifier).cambiarOrdenElementos(
                      idLista: widget.idLista, 
                      idElemento: this._elementos[i].id, 
                      nuevoOrden: this._elementos[i].orden-1
                    );
                  }
                }
                else{
                  for ( int i = newIndex; i < oldIndex; i++){
                    ref.read(listasProvider.notifier).cambiarOrdenElementos(
                      idLista: widget.idLista, 
                      idElemento: this._elementos[i].id, 
                      nuevoOrden: this._elementos[i].orden+1
                    );
                  }
                }
              },
              children: this._elementos.map((elemento) => _ElememtoCard(
                key: ValueKey(elemento.id),
                elemento: elemento,
                onTap: () {
                  ref.read(listasProvider.notifier).toogleElementoTachado(idLista: widget.idLista, idElemento: elemento.id);
                },
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
  final VoidCallback _onTap;

  const _ElememtoCard({super.key, required this._elemento, required this._onTap});

  @override
  Widget build(BuildContext context) {

    Color colorFondo;
    if(this._elemento.tachado){
      colorFondo = AppColor.colorElementoTachado;
    }
    else{
      colorFondo = AppColor.colorIconLista;
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      color: colorFondo,
      child: InkWell(
        onTap: this._onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingCard),
          child: Row(
            children: [
              Container(
                width: AppSizes.sizeStackIconLista,
                height: AppSizes.sizeStackIconLista,
                decoration: BoxDecoration(
                  color: colorFondo,
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
                          fontWeight: FontWeight.bold,
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
      ),
    );
  }
  
}