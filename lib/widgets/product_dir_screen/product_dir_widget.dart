import 'package:flutter/material.dart';
import 'package:mobile_traid/providers/product_watcher_provider.dart';
import 'package:mobile_traid/widgets/product_dir_screen/product_group_widget.dart';
import 'package:mobile_traid/widgets/product_dir_screen/product_widget.dart';
import 'package:provider/provider.dart';
// import 'package:http/http.dart';

class ProductDirWidget extends StatelessWidget {
  const ProductDirWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${context.watch<ProductWatcher>().title}',
          style: const TextStyle(fontSize: 17),
        ),
        actions: context.read<ProductWatcher>().rootGroup == null
            ? []
            : [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Center(
                    child: IndexedStack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // context.read<TapWatcher>().setTitle('test');
                            context.read<ProductWatcher>().up();
                            // upGroup();
                          },
                          child: const Icon(
                            Icons.drive_folder_upload,
                            size: 30.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
        // automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        // padding: EdgeInsets.only(top: 70),
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: context.read<ProductWatcher>().products.length, //products.length,
        itemExtent: 85,
        itemBuilder: (BuildContext context, int index) {
          return context.read<ProductWatcher>().products[index].isGroup
              ? ProductGroupWidget(index: index)
              : ProductWidget(index: index);
        },
      ),
    );
  }
}


// @override
//   Widget build(BuildContext context) {
//     return Consumer<TapWatcher>(
//       builder: (context, value, child) => Scaffold(
//           appBar: AppBar(
//             title: Text(
//               '${context.read<TapWatcher>().title}',
//               style: const TextStyle(fontSize: 17),
//             ),
//             actions: context.read<TapWatcher>().rootGroup == null
//                 ? []
//                 : [
//                     Padding(
//                       padding: const EdgeInsets.only(right: 20.0),
//                       child: Center(
//                         child: IndexedStack(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 context.read<TapWatcher>().setTitle('test');
//                                 // context.read<TapWatcher>().upGroup();
//                                 // upGroup();
//                               },
//                               child: const Icon(
//                                 Icons.drive_folder_upload,
//                                 size: 30.0,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//             // automaticallyImplyLeading: false,
//           ),
//           body: ListView.builder(
//             // padding: EdgeInsets.only(top: 70),
//             // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//             itemCount: context.read<TapWatcher>().products.length, //products.length,
//             itemExtent: 85,
//             itemBuilder: (BuildContext context, int index) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                 child: Stack(
//                   children: [
//                     DecoratedBox(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 8,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                         border: Border.all(color: Colors.black.withOpacity(0.2)),
//                         borderRadius: const BorderRadius.all(Radius.circular(10)),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: const BorderRadius.all(Radius.circular(10)),
//                         child: Row(
//                           children: [
//                             const Padding(
//                               padding: EdgeInsets.all(5.0),
//                               child: Icon(Icons.folder_open),
//                             ),
//                             // const SizedBox(width: 15),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const SizedBox(height: 7),
//                                   Text(context.read<TapWatcher>().products[index].name
//                                       // products[index].name,//context.read<TapWatcher>().getGroupsByParentId()[index].name, //
//                                       //   style: TextStyle(fontWeight: FontWeight.bold),
//                                       //   maxLines: 1,
//                                       //   overflow: TextOverflow.ellipsis,
//                                       ),
//                                   // SizedBox(height: 5),
//                                   // Text(
//                                   //   'test string 1',
//                                   //   style: TextStyle(color: Colors.grey),
//                                   //   maxLines: 1,
//                                   //   overflow: TextOverflow.ellipsis,
//                                   // ),
//                                   // SizedBox(height: 5),
//                                   // Text(
//                                   //   'test string 2',
//                                   //   maxLines: 1,
//                                   //   overflow: TextOverflow.ellipsis,
//                                   // ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(width: 5),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                           borderRadius: BorderRadius.circular(10),
//                           onTap: () {
//                             context.read<TapWatcher>().onTapHandler(context.read<TapWatcher>().products[index]);
//                           }
//                           // () => onTapHandler(products[index]),
//                           ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           )),
//     );
//   }