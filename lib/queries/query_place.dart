class QueryPlace {
  
  static String getAll = """
    query getAll{
      places {
        id
        name
        type
        image
        address
        lat
        lng
        category {
          id
          name
          value
        }
      }
    }
  """;

  static String getReviews = """
    query getReviews(\$placeId: Int!) {
      review(id: \$placeId}}) {
        id
        description
        score
        user {
          id
          first_name
          last_name
          image
        }
        created_at
      }
    }
  """; 
}