class QueryKind {

  static String getAll = """
    query getAll {
      kinds {
        id
        name
      }
    }
  """;

  static String getOne = """
    query getOne(\$kindId: Int!) {
      kind(id: \$kindId}}) {
        id
        name
    }
  """;
}