import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listly/data/elemento.dart';
import 'package:listly/data/lista.dart';
import 'package:listly/notifier/listas_notifier.dart';
import 'package:listly/notifier/usuario_notifier.dart';
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
                onOpciones: () {
                  _mostrarOpciones(context, elemento);
                },
                )).toList(),
            ),
          ),
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarDialogoNuevoElemento(context),
        child: const Icon(Icons.add),
      ),
    );

  }


  void _mostrarOpciones(BuildContext context, Elemento elemento){
    showModalBottomSheet(
      context: context, 
      builder: (context){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Modificar Icono'),
              onTap: () {
                Navigator.pop(context);
                _mostrarDialogoEmoji(context, elemento);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Moficiar Nombre'),
              onTap: () {
                Navigator.pop(context);
                _mostrarDialogoNombre(context, elemento);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Eliminar'),
              onTap: () {
                Navigator.pop(context);
                ref.read(listasProvider.notifier).eliminarElemento(idLista: widget.idLista, idElemento: elemento.id);
              },
            ),
          ], 
        );
      }
    );
  }
  

  void _mostrarDialogoNombre(BuildContext context, Elemento elemento){
    final TextEditingController controller = TextEditingController(text: elemento.nombre);

    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('Modificar Nombre'),
          content: TextField(
            controller: controller,
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                ref.read(listasProvider.notifier).modifyElementoNombre(idLista: widget.idLista, idElemento: elemento.id, nombre: controller.text);
                Navigator.pop(context);
              },
              child: const Text('Guardar')
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      }
    );
  }

  void _mostrarDialogoEmoji(BuildContext context, Elemento elemento){
    final TextEditingController controller = TextEditingController(text: elemento.emoji);

    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('Modificar Emoji'),
          content: TextField(
            controller: controller,
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                ref.read(listasProvider.notifier).modifyElementoEmoji(idLista: widget.idLista, idElemento: elemento.id, emoji: controller.text);
                Navigator.pop(context);
              },
              child: const Text('Guardar')
            ),            
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      }
    );
  }

  void _mostrarDialogoNuevoElemento(BuildContext context){
    final TextEditingController controllerEmoji = TextEditingController();    
    final TextEditingController controllerNombre = TextEditingController();

    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('Modificar Emoji'),
          content: Column(
            children: [
              TextField(
                controller: controllerEmoji,
                decoration: const InputDecoration(labelText: 'Emoji'),
              ),
              const SizedBox(height: AppSizes.heightAlertDialog),
              TextField(
                controller: controllerNombre,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle(color: Colors.red),),
            ),
            TextButton(
              onPressed: () {

                ref.read(listasProvider.notifier).addElemento(
                  idLista: widget.idLista, 
                  usuarioCreador: ref.read(usuarioProvider), 
                  nombre: controllerNombre.text, 
                  emoji: controllerEmoji.text
                );

                Navigator.pop(context);
              },
              child: const Text('Guardar')
            )
          ],
        );
      }
    );
  }
  
}

class _ElememtoCard extends StatelessWidget{

  final Elemento _elemento;
  final VoidCallback _onTap;
  final VoidCallback _onOpciones;

  const _ElememtoCard({super.key, required this._elemento, required this._onTap, required this._onOpciones});

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
              
              const SizedBox(width: AppSizes.widthCardSizeBoxRow),
              
              IconButton(
                onPressed: this._onOpciones, 
                icon: const Icon(
                  Icons.more_vert,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  
}