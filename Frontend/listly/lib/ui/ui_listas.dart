import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listly/data/lista.dart';
import 'package:listly/notifier/repository_notifier.dart';
import 'package:listly/theme/app_color.dart';
import 'package:listly/theme/app_sizer.dart';
import 'package:listly/ui/ui_elementos.dart';


class ListasPage extends ConsumerStatefulWidget{
  final String tituloPage;
  const ListasPage({super.key, required this.tituloPage});
  
  @override
  ConsumerState<ListasPage> createState() => _ListaPageState();
}

class _ListaPageState extends ConsumerState<ListasPage>{

  List<Lista> _listas = [];
  final TextEditingController _buscadorController = TextEditingController();
  Ordenar _ordenActual = Ordenar.alfabetico;

  @override
  Widget build(BuildContext context) {

    final  mapaListasAsync = ref.watch(repositoryProvider.select(
      (async) => async.whenData((appState) => appState.listas)
    ));

    return mapaListasAsync.when(
      data: (data) => _pantallaPrincipal(data), 
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
        child: Text('Error al cargar las listas: ${error}'),
      ),
    );
  }

  Widget _pantallaPrincipal(Map<int, Lista> mapaListas){
    this._listas = mapaListas.values.toList();
    this._filtrarLista();
    this._ordenarViewLista();
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.tituloPage),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(AppSizes.radioIconLista),
                  bottomRight: Radius.circular(AppSizes.radioIconLista),
                ),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              padding: const EdgeInsets.all(AppSizes.paddingBuscador),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: this._buscadorController,
                      decoration: const InputDecoration(
                        hintText: "Buscar lista...",
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (text) {
                        setState(() {},);
                      },
                    ),
                  ),
                  const SizedBox(width: AppSizes.widthBusquedaSizedBoxRow),
                  Row(
                    children: [        
                      Icon(Icons.sort),      
                      const SizedBox( width: AppSizes.widthOrdenarSizedBoxRow),      
                      DropdownButton<Ordenar>(
                        value: this._ordenActual,
                        items: Ordenar.values.map((orden) => DropdownMenuItem(value: orden ,child: Text(orden.texto))).toList(), 
                        onChanged: (nuevoOrden) {
                          setState(() {
                            this._ordenActual = nuevoOrden!;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(child: 
              _listas.isEmpty 
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.checklist, size: AppSizes.vacioIconSize, color: AppColor.colorVacio,),
                    const SizedBox(height: AppSizes.vacioEspacioSuperior),
                    const Text(
                      'No hay listas',
                      style: TextStyle(fontSize: AppSizes.vacioFuenteTamanoSuperior, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: AppSizes.vacioEspacioInferior),
                    const Text(
                      'Toca el botón + para añadir la primera lista',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColor.colorVacio),
                    ),
                  ],
                ),
              )
              :  ListView(
                  padding: const EdgeInsets.all(AppSizes.paddingListaView),
                  children:
                    this._listas.map((lista) => _ListaCard(
                      lista: lista,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ElementosPage(idLista: lista.id,))
                        );
                      },
                      onOpciones: () => this._mostrarOpciones(context, lista),
                      )).toList(),
                )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarDialogoNuevoElemento(context),
        child: const Icon(Icons.add),
      ),
    );
  }
  
  void _filtrarLista(){
    if(this._buscadorController.text.isNotEmpty){
      this._listas = this._listas.where(
        (element) => element.nombre.toLowerCase().contains(
          this._buscadorController.text.toLowerCase()
          )
        ).toList();
    }
  }

  void _ordenarViewLista(){
    switch(this._ordenActual){                            
      case Ordenar.alfabetico:
        this._listas.sort((a, b) => a.nombre.compareTo(b.nombre),);
      case Ordenar.recienModif:
        this._listas.sort((a, b) => a.modificacion.compareTo(b.modificacion));
      case Ordenar.antiguaModif:
        this._listas.sort((a, b) => b.modificacion.compareTo(a.modificacion));
    }
  }

  void _mostrarOpciones(BuildContext context, Lista lista){
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
                  _mostrarDialogoEmoji(context, lista);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Moficiar Nombre'),
                onTap: () {
                  Navigator.pop(context);
                  _mostrarDialogoNombre(context, lista);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Eliminar'),
                onTap: () {
                  Navigator.pop(context);
                  _confirmacionEliminacion(context, lista);
                },
              ),
            ], 
          )
        );
      }
    );
  }
  

  void _mostrarDialogoNombre(BuildContext context, Lista lista){ 
    final TextEditingController controller = TextEditingController(text: lista.nombre);

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
                ref.read(repositoryProvider.notifier).modificarListaNombre(idLista: lista.id, nombreLista: controller.text);
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

  void _mostrarDialogoEmoji(BuildContext context, Lista lista){
    final TextEditingController controller = TextEditingController(text: lista.emoji);

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
                ref.read(repositoryProvider.notifier).modificarListaEmoji(idLista: lista.id, emojiLista: controller.text);
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

  void _confirmacionEliminacion(BuildContext context, Lista lista){
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('¿Eliminar lista?'),
          content: Text('Se elimnará "${lista.nombre}"'),
          actions: [            
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('No')
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ref.read(repositoryProvider.notifier).eliminarLista(idLista: lista.id);
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
          title: const Text('Añadir lista'),
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

                ref.read(repositoryProvider.notifier).crearLista(
                  nombreLista: controllerNombre.text, 
                  emojiLista: controllerEmoji.text
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


class _ListaCard extends StatelessWidget{

  final Lista _lista;
  final VoidCallback _onTap;
  final VoidCallback _onOpciones;

  const _ListaCard({super.key, required this._lista, required this._onTap, required this._onOpciones});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: this._onTap,
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

enum Ordenar{
  alfabetico("Alfabético"),
  recienModif("Modif. mas reciente"),
  antiguaModif("Modif. mas antigua");

  final String texto;

  const Ordenar(this.texto);
} 