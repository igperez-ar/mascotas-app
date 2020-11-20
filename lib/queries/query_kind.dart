class QueryKind {

  static String getAll = """
    query getAll {
      kind {
        id
        name
      }
    }
  """;

  static String getOne = """
    query getOne(\$kindId: Int!) {
      kind(where: {kindId: {_eq: \$kindId}}) {
        id
        name
    }
  """;
}