class QueryPlace {
  
  static String getAll = """
    {
      place {
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
      review(where: {place_id: {_eq: \$placeId}}) {
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