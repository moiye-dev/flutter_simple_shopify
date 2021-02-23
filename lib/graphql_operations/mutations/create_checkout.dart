const String createCheckoutMutation = r'''
mutation MyMutation($note: String!) {
  checkoutCreate(input: {note: $note}) {
    checkout {
      id
      note
    }
  }
}
''';
