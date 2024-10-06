import 'package:flutter/material.dart';

import 'image_constant.dart';
import 'camera/plant_model.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.listDetail});

  final List listDetail;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(ImageConstant.topDetailDecoration),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, top: 32),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_sharp,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox.expand(
            child: DraggableScrollableSheet(
                maxChildSize: 1,
                initialChildSize: 0.8,
                minChildSize: 0.75,
                builder: ((context, scrollController) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(25.0),
                          topRight: const Radius.circular(25.0),
                        ),
                      ),
                      child: Column(children: [
                        Text(
                          widget.listDetail[0]!,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        Container(
                          width: 350,
                          height: 300,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.network(
                            //"https://www.itying.com/images/201906/goods_img/1120_P_1560842352183.png",
                            ((((widget.listDetail)[4])[0])['url'])['s']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DetailSectionWidget(
                          titleSection: "Family",
                          valueSection: widget.listDetail[1]!,
                        ),
                        DetailSectionWidget(
                          titleSection: "Genus",
                          valueSection: widget.listDetail[2]!,
                        ),
                        DetailSectionWidget(
                          titleSection: "Common Name(s)",
                          valueSection: widget.listDetail[3][0]!,
                        ),
                      ]),
                    ),
                  );
                })),
          )
        ],
      ),
    );
  }
}

class DetailSectionWidget extends StatelessWidget {
  const DetailSectionWidget(
      {super.key, required this.titleSection, required this.valueSection});
  final String titleSection;
  final String valueSection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleSection,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            valueSection,
            style: TextStyle(
                letterSpacing: 0.6,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            thickness: 2,
            color: Colors.grey.withOpacity(0.1),
          ),
        ],
      ),
    );
  }
}