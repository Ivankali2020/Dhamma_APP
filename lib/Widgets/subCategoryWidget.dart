import 'package:flutter/cupertino.dart';

import '../Modal/subCategory.dart';
import 'package:flutter/material.dart';

class subCategoryWidget extends StatelessWidget {
  final Function Detail;
  final List<subCategory> categories;
  // final Widget detail;
  const subCategoryWidget(this.categories,this.Detail);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, i) {
          return Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categories[i].name,
                      style:
                         const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('စုစုပေါင်း : ${categories[i].mediasCount}')
                  ],
                ),
                IconButton(
                  onPressed: () => Detail(context,categories[i].id,categories[i].name),
                  icon: const Icon(CupertinoIcons.right_chevron),
                ),
              ],
            ),
          );
        });
  }
}
