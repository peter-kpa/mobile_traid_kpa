import 'package:flutter/material.dart';

import 'package:mobile_traid/models/entity_model.dart';

class OrganizationWidget extends StatelessWidget {
  final Organization organization;
  final int index;
  final Function onTapHandler;
  final Function dismiss;

  const OrganizationWidget({
    Key? key,
    required this.organization,
    required this.index,
    required this.onTapHandler,
    required this.dismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
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
                      child: Icon(Icons.account_circle_outlined),
                    ),
                    const SizedBox(
                      width: 15,
                      height: 50,
                    ),
                    Expanded(
                      child: Text(
                        organization.name,
                        style: const TextStyle(fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxHeight: 50),
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  onTapHandler(organization);
                  // Navigator.pop(context);
                },
                onLongPress: () {
                  print('hello');
                },
              ),
            ),
            // Container(
            //   constraints: const BoxConstraints(maxHeight: 50),
            //   color: Colors.transparent,
            //   child: Material(
            //     color: Colors.transparent,
            //     child: InkWell(
            //       borderRadius: BorderRadius.circular(10),
            //       onTap: () {
            //         onTapHandler(manager);
            //         // Navigator.pop(context);
            //       },
            //     ),
            //   ),
            // ),
          ],
        ));
  }
}
