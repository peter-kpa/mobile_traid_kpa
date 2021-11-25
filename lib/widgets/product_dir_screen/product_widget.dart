import 'package:flutter/material.dart';
import 'package:mobile_traid/providers/product_watcher_provider.dart';
import 'package:provider/src/provider.dart';

class ProductWidget extends StatelessWidget {
  final int index;

  const ProductWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Stack(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(color: Colors.black.withOpacity(0.2)),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(Icons.clear_all),
                  ),
                  // const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 7),
                        Text(context.read<ProductWatcher>().products[index].name
                            // products[index].name,//context.read<TapWatcher>().getGroupsByParentId()[index].name, //
                            //   style: TextStyle(fontWeight: FontWeight.bold),
                            //   maxLines: 1,
                            //   overflow: TextOverflow.ellipsis,
                            ),
                        // SizedBox(height: 5),
                        // Text(
                        //   'test string 1',
                        //   style: TextStyle(color: Colors.grey),
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                        // SizedBox(height: 5),
                        // Text(
                        //   'test string 2',
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  var tw = context.read<ProductWatcher>();
                  context
                      .read<ProductWatcher>()
                      .setChosenProduct(tw.products[index]);
                  Navigator.pop(context);
                },
                onDoubleTap: () {
                  var tw = context.read<ProductWatcher>();
                  tw.onTapHandler(tw.products[index]);
                  context.read<ProductWatcher>().parentId =
                      Navigator.of(context)
                          .pushNamed('/productCard',
                              arguments: tw.products[index])
                          .toString();
                }
                // () => onTapHandler(products[index]),
                ),
          ),
        ],
      ),
    );
  }
}
