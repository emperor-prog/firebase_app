import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/custom_button.dart';
import 'package:flutter_application_1/features/cart/models/cart_product.dart';
import 'package:flutter_application_1/features/shop/models/products_model.dart';
import 'package:flutter_application_1/services/cart_service.dart';
import 'package:flutter_application_1/utils/custom_color.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final CartService cartservice = CartService();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: CustomColor.appBackGroundColor,
          elevation: 7,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          builder: (BuildContext context) {
            return SizedBox(
              height: 350,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Divider(
                        endIndent: 180,
                        indent: 180,
                        height: 4,
                        thickness: 3,
                        color: CustomColor.textBlackColor,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Select size',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: CustomColor.textBlackColor),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 15.0,
                        runSpacing: 12.0,
                        children: <String>['XS', 'S', 'M', 'XL', 'XXL']
                            .map((e) => Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: CustomColor.textGreyColor,
                                        width: 1),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                      child: Text(
                                    e,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  )),
                                ))
                            .toList(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 350,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.symmetric(
                                horizontal: BorderSide(
                                    color: CustomColor.textGreyColor
                                        .withOpacity(0.5),
                                    width: 1))),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Size info',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: CustomColor.textBlackColor),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: CustomColor.textGreyColor,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                          buttonText: 'ADD TO CART',
                          onPressed: () {
                            cartservice.addToCart(
                              product: CartItem(
                                count: 1,
                                id: widget.product.id,
                                title: widget.product.title,
                                price: widget.product.price,
                                image: widget.product.image,
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 150,
                  height: 200,
                  decoration: BoxDecoration(
                    color: CustomColor.textGreyColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.product.image),
                    ),
                  ),
                ),
                const Positioned(
                  right: -10,
                  bottom: -10,
                  child: Card(
                    elevation: 8,
                    color: CustomColor.appBackGroundColor,
                    shape: CircleBorder(),
                    child: SizedBox(
                      width: 45,
                      height: 45,
                      child: Icon(Icons.favorite_border_outlined),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            Row(
              children: [
                RatingBar.builder(
                  initialRating: widget.product.rating.rate,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemPadding: const EdgeInsets.all(0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                Text(
                  '(${widget.product.rating.count})',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              child: Text(
                widget.product.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              child: Text(
                '${widget.product.price}\$',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
