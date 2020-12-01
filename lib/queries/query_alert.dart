class QueryAlert {

  static String getAll = """
    query getAlerts{
      urbanAlerts {
        id
        type {
          id
          name
        }
        description
    		images {
          image
          order
        }
        user {
          name
          image
        }
        lat
        lng
         comments {
          id
          user {
            id
            name
            image
          }
          content
        }
        state {
          id
          name
        }
        createdAt
        updatedAt
      }
    }
  """;

  static String addAlert = """
    mutation addAlert (\$description: String!, \$lat: Float!, \$lng: Float!, \$userId: Int!, \$typeId: Int!, \$photos: [Upload]) {
      createUrbanalert(description: \$description, lat: \$lat, lng: \$lng, userId: \$userId, typeId: \$typeId, photos: \$photos,
      ) {
        urbanAlert {
          id
          type {
            name
          }
          description
          lat
          lng
          user {
            id 
            email
          }
        }
      }
    }
  """;
}