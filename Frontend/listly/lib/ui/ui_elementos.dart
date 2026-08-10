import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listly/data/elemento.dart';
import 'package:listly/data/lista.dart';
import 'package:listly/notifier/repository_notifier.dart';
import 'package:listly/theme/app_color.dart';
import 'package:listly/theme/app_sizer.dart';


class ElementosPage extends ConsumerStatefulWidget{

  final int idLista;

  ElementosPage({super.key, required this.idLista});
  
  @override
  ConsumerState<ElementosPage> createState() => _ElementosPageState();  
}

class _ElementosPageState extends ConsumerState<ElementosPage>{
  
  //late Lista _lista;
  late List<Elemento> _elementos;

  @override
  Widget build(BuildContext context) {

    final mapaElementosAsync = ref.watch(repositoryProvider.select(
      (async) => async.whenData((appState) {
        final lista = appState.listas[widget.idLista]!;
        return (lista: lista, modificacion : lista.modificacion);
      }),
    ));
    
    return mapaElementosAsync.when(
      data: (data) => _pantallaPrincipal(data.lista), 
      error: (error, stackTrace) => _pantallaError(error, stackTrace), 
      loading: () => _pantallaCargando(),
    );   
  }

  Widget _pantallaCargando(){
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _pantallaError(Object error, StackTrace stackTrace){
    print('\n\n ERROR: $error  \n\n STACKTRACE: $stackTrace');
    return Scaffold(
      body: Center(
        child: Text('Error al cargar la lista: ${error}'),
      ),
    );
  }

  Widget _pantallaPrincipal(Lista lista){
    this._elementos = lista.elementos;

    for( Elemento elemento in _elementos){
      print(" \n\n\n ${elemento.nombre} - ${elemento.orden}");
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context), 
          icon: const Icon(Icons.arrow_back)
        ),
        title: Text(lista.nombre),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _elementos.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.checklist, size: AppSizes.vacioIconSize, color: AppColor.colorVacio,),
                    const SizedBox(height: AppSizes.vacioEspacioSuperior),
                    const Text(
                      'Esta lista está vacía',
                      style: TextStyle(fontSize: AppSizes.vacioFuenteTamanoSuperior, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: AppSizes.vacioEspacioInferior),
                    const Text(
                      'Toca el botón + para añadir el primer elemento',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColor.colorVacio),
                    ),
                  ],
                ),
              )              
              : ReorderableListView(
                padding: const EdgeInsets.all(AppSizes.paddingListaView),
                onReorderItem: (oldIndex, newIndex) {
                  if(oldIndex != newIndex){
                    ref.read(repositoryProvider.notifier).elementoCambiarOrden(
                      idLista: widget.idLista, 
                      idElemento: _elementos[oldIndex].id, 
                      antiguoOrden: oldIndex, 
                      nuevoOrden: newIndex
                    );
                  }
                },
                children: this._elementos.map((elemento) => _ElememtoCard(
                  key: ValueKey(elemento.id),
                  elemento: elemento,
                  onTap: () {
                    ref.read(repositoryProvider.notifier).elementoToogleTachado(idLista: widget.idLista, idElemento: elemento.id);
                  },
                  onOpciones: () {
                    _mostrarOpciones(context, elemento);
                  },
                  )).toList(),
              ),
            ),
            
          ],
        ),
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
        return SafeArea(
          child: Column(
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
                  _confirmacionEliminacion(context, elemento);
                },
              ),
            ], 
          ),
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
                ref.read(repositoryProvider.notifier).modificarElementoNombre(idLista: widget.idLista, idElemento: elemento.id, nombreElmento: controller.text);
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
                ref.read(repositoryProvider.notifier).modificarElementoEmoji(idLista: widget.idLista, idElemento: elemento.id, emojiElemento: controller.text);
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

  void _confirmacionEliminacion(BuildContext context, Elemento elemento){
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('¿Eliminar elemento?'),
          content: Text('Se elimnará "${elemento.nombre}" de esta lista'),
          actions: [            
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('No')
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ref.read(repositoryProvider.notifier).eliminarElemento(idLista: widget.idLista, idElemento: elemento.id);
              }, 
              child: const Text('Sí, eliminar', style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoNuevoElemento(BuildContext context){
    final TextEditingController controllerEmoji = TextEditingController();    
    final TextEditingController controllerNombre = TextEditingController();

    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('Añadir elemento'),
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

                ref.read(repositoryProvider.notifier).crearElemento(
                  idLista: widget.idLista, 
                  nombreElemento: controllerNombre.text, 
                  emojiElemento: controllerEmoji.text
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