import 'package:graphql/client.dart';

mixin ShopifyError {
  /// throws a [OperationException] if the operation was wrong
  /// throws a [ShopifyException] if shopify reports an error
  void checkForError(QueryResult queryResult, {String key, String errorKey}) {
    if (queryResult.hasException) throw queryResult.exception;
    if (key != null && errorKey != null) {
      Map<String, Object> data = (queryResult?.data as LazyCacheMap)?.data;
      Map<String, Object> content = data[key];
      if (content == null) return;
      List errors = content[errorKey];
      if (errors != null && errors.isNotEmpty) {
        errors.forEach((error) => print(error));
        throw ShopifyException(key, errorKey, errors: errors);
      }
    }
  }

  /// Checks and throws an [CheckoutCompleteException] when
  /// the [QueryResult] contains checkout errors
  /// also run [checkForError] for normal error handling
  void checkForCheckoutError(QueryResult queryResult) {
    checkForError(queryResult);

    final checkoutCompleteFreeData = queryResult.data['checkoutCompleteFree'];
    if (checkoutCompleteFreeData != null) {
      if (checkoutCompleteFreeData['checkoutUserErrors']?.isNotEmpty) {
        checkoutCompleteFreeData['checkoutUserErrors']
            .forEach((error) => print(error.data));
        throw CheckoutCompleteException('Error on checkoutCompleteFree',
            errors: checkoutCompleteFreeData['checkoutUserErrors']);
      }
    }
  }
}

/// Exception thrown when a checkout fails
/// like when some items are out of stock
class CheckoutCompleteException implements Exception {
  /// A message describing the issue
  final String message;

  /// The list of errors, might contains items out of stock or other item-related
  /// errors
  final List<dynamic> errors;

  const CheckoutCompleteException(this.message, {this.errors});
}

class ShopifyException implements Exception {
  /// The shopify operation in which the error occurred
  final String key;

  /// The type of the error
  final String errorKey;

  /// The list of errors, might contains items out of stock or other item-related
  /// errors
  final List<dynamic> errors;

  const ShopifyException(this.key, this.errorKey, {this.errors});

  @override
  String toString() {
    return "$errorKey during $key: $errors";
  }
}
