import 'package:flutter/material.dart';
import 'package:mobile_traid/providers/product_watcher_provider.dart';
import 'package:provider/src/provider.dart';

class ProductGroupWidget extends StatelessWidget {
  final int index;

  const ProductGroupWidget({
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
                    child: Icon(Icons.folder_open),
                  ),
                  const SizedBox(
                    width: 15,
                    height: 150,
                  ),
                  Expanded(
                    child: Text(
                      context.read<ProductWatcher>().products[index].name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                  context.read<ProductWatcher>().onTapHandler(context.read<ProductWatcher>().products[index]);
                }
                // () => onTapHandler(products[index]),
                ),
          ),
        ],
      ),
    );
  }
}
