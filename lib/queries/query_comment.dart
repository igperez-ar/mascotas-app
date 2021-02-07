class QueryComment {

  static String addComment = """
    mutation addComment(
      \$alertId: Int!,
      \$userId: Int!,
      \$content: String!,
    ) {
      createComment(
        alertId: \$alertId,
        userId: \$userId,
        content: \$content,
      ) {
        __typename
      }
    }
  """;
}