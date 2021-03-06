const String customerDefaultAddressUpdateMutation = r'''
mutation customerDefaultAddressUpdate($customerAccessToken: String!, $addressId: ID!) {
  customerDefaultAddressUpdate(customerAccessToken: $customerAccessToken, addressId: $addressId ) {
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
