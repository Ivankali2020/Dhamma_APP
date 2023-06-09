import 'package:dhamma/Utlis/Loading.dart';

import '../Helper/fadePageRoute.dart';
import '../Modal/BLog.dart';
import '../Provider/DataProvider.dart';
import '../Screen/BLogDetail.dart';
import '../Utlis/EmptyLists.dart';
import 'package:flutter/material.dart';
import '../Screen/Blog.dart' as blogScreen;
import 'package:provider/provider.dart';

class blogWidget extends StatelessWidget {
  const blogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<DataProvider>(context, listen: false)
            .fetchBlogMedias(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Container(
              height: 120,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Loading(
                        width: 120,
                      ),
                    );
                  }),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final blogs = Provider.of<DataProvider>(context).blogMedias;
            return blogs.isEmpty
                ? const EmptyList('မှတ်တမ်းမှတ်ရာ မရှိသေးပါဗျာ')
                : SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                      itemCount: blogs.length,
                      itemBuilder: (context, i) {
                        return blog(blogs[i], context);
                      }),
                );

                //  Row(
                //     children: [
                //       ...videos.map((e) => blog(e, context)).toList(),
                //       InkWell(
                //         onTap: () {
                //           Navigator.of(context).push(
                //             fadePageRoute(
                //               'videoList',
                //               blogScreen.Blog(),
                //             ),
                //           );
                //         },
                //         borderRadius: BorderRadius.circular(10),
                //         child: Container(
                //           height: 120,
                //           width: 180,
                //           alignment: Alignment.center,
                //           decoration: BoxDecoration(
                //             border: Border.all(color: Colors.grey),
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //           child: const Text('ထပ်ကြည့်ရန်'),
                //         ),
                //       ),
                //     ],
                //   );
          }
          return const Center(
            child: Text('What Happending?'),
          );
        });
  }
}

Widget blog(Blog blog, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(right:8.0),
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.of(context).push(fadePageRoute(
            'blogDetail', blogDetail(blog),
            arguments: {'data': blog}));
      },
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              blog.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              blog.category,
              style: TextStyle(),
            ),
            Text(
              blog.subCategory,
              style: TextStyle(),
            ),
          ],
        ),
      ),
    ),
  );
}
