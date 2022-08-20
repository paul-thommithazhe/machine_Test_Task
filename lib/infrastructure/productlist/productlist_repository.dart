import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:demo/core/api_endpoints.dart';
import 'package:demo/domain/productlist/i_show_productlist_repo.dart';
import 'package:demo/domain/productlist/models.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

@LazySingleton(as: IshowProductListRepo)
class ShowProductListRepository implements IshowProductListRepo {
  @override
  Future<Either<String, List<ProductList>>> getProductList() async {
    try {
      var response = await http.get(Uri.parse(ApiEndPoints.fetchProducts));
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = productListFromJson(response.body);

        return right(data);
      }
    } catch (e) {
      log(e.toString());
    }

    return left('Something Wrong');
  }
}

@LazySingleton(as: IshowCurentProductRepo)
class ShowCurrentProductRepository implements IshowCurentProductRepo {
  @override
  Future<Either<String, ProductList>> getCurrentProduct(
      {required int id}) async {
    try {
      var response = await http.get(Uri.parse(
        "${ApiEndPoints.fetchProducts}/$id",
      ));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        ProductList currentProduct = ProductList.fromJson(data);

        return right(currentProduct);
      }
    } catch (e) {
      log(e.toString());
    }
    return left('Something Wrong');
  }
}
