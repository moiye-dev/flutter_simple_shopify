const String customerDefaultAddressUpdateMutation = r'''
mutation customerDefaultAddressUpdate($id: ID!, $customerAccessToken: String!) {
  customerDefaultAddressUpdate(id: $id, customerAccessToken: $customerAccessToken) {
    customerUserErrors {
      code
      field
      message
    }
  }
}
''';
