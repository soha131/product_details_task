import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/product_details_cubit.dart';
import '../cubit/product_details_state.dart';
import '../data/models/product_model.dart';
import '../data/repository/product_repo.dart';
import '../widgets/bottom_buy_bar.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/product_tab.dart';
import 'help_screen.dart';
import 'review_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              ProductDetailsCubit(context.read<ProductRepository>())
                ..getProductDetails(productId),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFFFE7E00)),
              );
            }
            if (state is ProductDetailsError) {
              return Center(child: Text(state.message));
            }
            if (state is ProductDetailsSuccess) {
              return ProductDetailsBody(product: state.product);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: const BackButton(color: Colors.black),
      title: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          final category =
              state is ProductDetailsSuccess
                  ? state.product.category.name
                  : '...';
          return Text(
            "Clothes / $category",
            style: const TextStyle(color: Colors.black, fontSize: 16),
          );
        },
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }
}

class ProductDetailsBody extends StatefulWidget {
  final Product product;
  const ProductDetailsBody({super.key, required this.product});

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool isDescriptionExpanded = true;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTabBar(controller: _tabController),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              ProductTab(
                product: widget.product,
                isDescriptionExpanded: isDescriptionExpanded,
                onToggleDescription:
                    () => setState(
                      () => isDescriptionExpanded = !isDescriptionExpanded,
                    ),
              ),
              ReviewsTab(reviews: widget.product.reviews),
              const HelpTab(),
            ],
          ),
        ),
        BottomBuyBar(
          quantity: quantity,
          onIncrease: () => setState(() => quantity++),
          onDecrease: () => quantity > 1 ? setState(() => quantity--) : null,
        ),
      ],
    );
  }
}
