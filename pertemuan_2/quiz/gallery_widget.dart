import 'package:flutter/material.dart';

class GalleryWidget
    extends StatelessWidget {

  const GalleryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        const Text(
          'Gallery',

          style: TextStyle(
            fontSize: 18,
            fontWeight:
            FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 100,

          child: ListView(
            scrollDirection:
            Axis.horizontal,

            children: [

              imageItem(
                'https://picsum.photos/200',
              ),

              imageItem(
                'https://picsum.photos/201',
              ),

              imageItem(
                'https://picsum.photos/202',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget imageItem(String url) {

    return Container(

      margin:
      const EdgeInsets.only(
        right: 12,
      ),

      width: 100,

      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(
          12,
        ),

        image: DecorationImage(
          image:
          NetworkImage(url),

          fit: BoxFit.cover,
        ),
      ),
    );
  }
}