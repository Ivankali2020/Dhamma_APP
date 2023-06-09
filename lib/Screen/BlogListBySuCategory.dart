import '../Modal/BLog.dart';
import '../Provider/BlogProvider.dart';
import '../Widgets/blogWidget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogListBySuCategory extends StatelessWidget {
  final int subCategoryId;
  final String subCategroyName;
  BlogListBySuCategory(this.subCategoryId, this.subCategroyName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subCategroyName),
      ),
      body: FutureBuilder(
        future: Provider.of<BlogProvider>(context, listen: false)
            .fetchBlogMediasBySubCategory(subCategoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            final List<Blog> blogs =
                Provider.of<BlogProvider>(context).blogMedias;
            return blogs.isEmpty
                ? const Center(
                    child: Text('မတွေ့ရှိပါ ခင်ဗျာ'),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: blogs.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: blog(blogs[i], context),
                        );
                      },
                    ),
                  );
          }

          return const Center(
            child: Text('What Happened?'),
          );
        },
      ),
    );
  }
}
