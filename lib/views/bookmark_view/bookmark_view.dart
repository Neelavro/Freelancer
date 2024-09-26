import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/services/bookmark_data_service.dart';
import 'package:xilancer/utils/components/empty_widget.dart';
import 'package:xilancer/views/home_view/components/job_card.dart';

import '../../helper/local_keys.g.dart';

class BookmarkView extends StatelessWidget {
  const BookmarkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          leadingWidth: 0,
          leading: const SizedBox(),
          title: Text(LocalKeys.bookmark),
        ),
        4.toHeight,
        Expanded(
          child: Consumer<BookmarkDataService>(builder: (context, bd, child) {
            return bd.bookmarkList.values.toList().isEmpty
                ? EmptyWidget(title: LocalKeys.noJobFound)
                : ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemBuilder: (context, index) {
                      final bItem = bd.bookmarkList.values.toList()[index];
                      final id = bItem['id'];
                      final title = bItem['title'];
                      final isFavorite = bItem['isFavorite'];
                      final createDate =
                          DateTime.tryParse(bItem['createDate'].toString());
                      final expertise = bItem['expertise'];
                      final price = bItem['price'];
                      final priceType = bItem['priceType'];
                      final summery = bItem['summery'];
                      final List<String> tags =
                          List<String>.from(bItem['tags']);
                      final location = bItem['location'];
                      final proposalCount = bItem['proposalCount'];
                      final deadline = bItem['deadline'];
                      final rating = bItem['rating'];
                      final bool userVerified = bItem['userVerified'];

                      return JobCard(
                        id: id,
                        title: title,
                        isFavorite: isFavorite,
                        createDate: createDate,
                        expertise: expertise,
                        price: price,
                        priceType: priceType,
                        summery: summery,
                        tags: tags,
                        location: location,
                        proposalCount: proposalCount,
                        deadline: deadline,
                        rating: rating,
                        userVerified: userVerified,
                        fromDetails: false,
                      );
                    },
                    separatorBuilder: (context, index) => 16.toHeight,
                    itemCount: bd.bookmarkList.length);
          }),
        ),
      ],
    );
  }
}
