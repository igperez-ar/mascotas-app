class QueryPlace {
  
  static String getAll = """
    query getPlaces {
      places {
        id
        name
        address
        lat
        lng
        type
        image
        category {
          id
          name
          value
        }
        avgScore
      }
    }
  """;

  static String getReviews = """
    query getReviews(\$placeId: Int!) {
      reviewsByPlace(placeId: \$placeId) {
        id
        score
        description
        user {
          id
          name
          image
        }
        createdAt
        updatedAt
      }
    }
  """; 
}