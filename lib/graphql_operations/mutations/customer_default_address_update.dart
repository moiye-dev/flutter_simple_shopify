const String customerDefaultAddressUpdateMutation = r'''
mutation customerDefaultAddressUpdate( $customerAccessToken: String!, $id: ID!) {
  customerDefaultAddressUpdate(customerAccessToken: $customerAccessToken, id: $id ) {
    customer {
      id
    }
    customerUserErrors {
      code
      field
      message
    }
  }
}
''';
