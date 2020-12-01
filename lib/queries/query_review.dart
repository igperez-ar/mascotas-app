class QueryReview {

  static String addReview = """
    mutation addReview(
      \$score: Int!,
      \$description: String!,
      \$placeId: Int!,
      \$userId: Int!
    ) {
      createReview (
        score: \$score,
        description: \$description,
        placeId: \$placeId,
        userId: \$userId
      ) {
        __typename
      }
    }
  """;

  static String updateReview = """
    mutation updateReview(\$reviewId: Int!, \$score: Int!, \$description: String!) {
      update_reviews(where: {id: {_eq: \$reviewId}}, _set: {score: \$score, description: \$description}) {
        affected_rows
      }
    }
  """;

  static String deleteReview = """
    mutation deleteReview(\$reviewId: Int!) {
      delete_reviews(where: {id: {_eq: \$reviewId}}) {
        affected_rows
      }
    }
  """;
}