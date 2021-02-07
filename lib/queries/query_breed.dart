class QueryBreed {

  static String getAll = """
    query getAll{
      breeds {
        id
        name
        kind {
          id
          name
        }
      }
    }
  """;
}