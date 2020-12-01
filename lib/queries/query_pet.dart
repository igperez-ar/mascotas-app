class QueryPet {

  static String addPet = """
    mutation addPet(
      \$name: String!,
      \$description: String!,
      \$birthDate: Date!,
      \$sex: String!,
      \$breedId: Int!,
      \$userId: Int!,
      \$files: [Upload]
    ) {
      createPet(
        name: \$name,
        description: \$description,
        birthDate: \$birthDate,
        sex: \$sex,
        breedId: \$breedId,
        userId: \$userId,
        files: \$files
      ) {
        __typename
      }
    }
  """;

  static String allAdoptions = """
    query allAdoptions {
      petsInAdoption {
        id
        name
        description
        images {
          id
          image
          order
        }
        birthDate
        breed {
          id
          name
          kind {
            id
            name
          }
        }
        sex
        tenureSet {
          id
          user {
            id
            name
            image
          }
          role {
            id
            name
          }
        }
      }
    }
  """;
}