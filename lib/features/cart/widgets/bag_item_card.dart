import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/cart/models/cart_product.dart';
import 'package:flutter_application_1/services/cart_service.dart';
import 'package:flutter_application_1/utils/custom_color.dart';

class BagItemCard extends StatefulWidget {
  const BagItemCard({
    super.key,
    required this.currentContact,
  });

  final CartItem? currentContact;

  @override
  State<BagItemCard> createState() => _BagItemCardState();
}

class _BagItemCardState extends State<BagItemCard> {
  final CartService services = CartService();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Row(children: [
                  Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 80,
                      height: 100,
                      child: Image.network(
                        widget.currentContact!.image,
                        fit: BoxFit.fitHeight,
                      )),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 150,
                              child: Text(
                                widget.currentContact!.title,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              width: 60,
                            ),
                            const Icon(Icons.more_vert)
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text("color:Black"),
                              SizedBox(
                                width: 10,
                              ),
                              Text("size:L"),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              InkWell(
                                onTap: () async {
                                  await services.removeFromCart(
                                      product: widget.currentContact!);
                                },
                                child: Card(
                                  elevation: 8,
                                  color: CustomColor.appBackGroundColor,
                                  shape: const CircleBorder(),
                                  child: SizedBox(
                                    width: 45,
                                    height: 45,
                                    child: Center(
                                      child: Text(
                                        "-",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child:
                                      Text('${widget.currentContact!.count}')),
                              InkWell(
                                onTap: () async {
                                  await services.addToCart(
                                      product: widget.currentContact!);
                                },
                                child: Card(
                                  elevation: 8,
                                  color: CustomColor.appBackGroundColor,
                                  shape: const CircleBorder(),
                                  child: SizedBox(
                                      width: 45,
                                      height: 45,
                                      child: Center(
                                          child: Text(
                                        "+",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ))),
                                ),
                              ),
                            ]),
                            const SizedBox(width: 30),
                            Text(
                              '${widget.currentContact!.price}\$',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ])
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
