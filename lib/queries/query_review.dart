class QueryReview {

  static String addReview = """
    mutation addReview(\$score: Int!, \$description: String!, \$userId: Int!, \$placeId: Int!) {
      insert_reviews(objects: {score: \$score, description: \$description, user_id: \$userId, place_id: \$placeId}) {
        affected_rows
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