class QueryUsuario {

  static String getAll = """
    {
      usuarios {
        id
        nombre
        descripcion
        foto
        email
        username
        password
      }
    }
  """;

  static String getOne = """
    query getOne(\$username: String!) {
      usuarios(where: {username: {_eq: \$username}}) {
        id
        nombre
        descripcion
        foto
        email
        username
        password
      }
    }
  """;

  static String addUsuario = """
    mutation addUsuario(\$nombre: String!, \$username: String!, \$password: String!, \$email: String!) {
      insert_usuarios(objects: [{nombre: \$nombre, username: \$username, password: \$password, email: \$email, miembros: {data: {rol_id: 3, grupo_id: 1}}}]) {
        returning {
          id
          nombre
          descripcion
          foto
          email
          username
          password
        }
      }
    }
  """;

  static String updateUsuario = """
    mutation updateUsuario(\$oldUsername: String!, \$nombre: String! \$foto: String! \$descripcion: String! \$email: String! \$newUsername: String! \$password: String!) {
      update_usuarios(where: {username: {_eq: \$oldUsername}}, _set: {nombre: \$nombre, foto: \$foto, descripcion: \$descripcion, email: \$email, username: \$newUsername, password: \$password}) {
        returning {
          id
          nombre
          foto
          descripcion
          email
          username
          password
        }
      }
    }
  """;

  /* Queries de la api en django */
  static String userRegister = """
    mutation userRegister(\$email: String!, \$password: String!, \$firstName: String!, \$lastName: String!) {
      userRegister(email: \$email,  password: \$email, firstName: \$firstName, lastName: \$lastName) {
        user {
          id
          firstName
          lastName
          email
          profilePicture
        }
      }
    }
  """;

  static String authenticate = """ 
    mutation authenticate(\$email: String!, \$password: String!) {
      tokenAuth(email: \$email, password: \$password) {
        payload
        token
        refreshExpiresIn    
        user {
          id 
          email 
          name
          image
        }
      }
    }
  """;

  static String register = """
  mutation registroUsuario(\$email:String!, \$password: String!, \$name: String!) {
    userRegister(email: \$email,  password: \$password, name: \$name) {
      user {
        id
      }
    }
  }
  """;

  static String getInfo = """
  query(\$id:Int!) {
    user(id:\$id) {
      id 
      email
      name
      image
      pets {
        id
        name
        description
        birthDate
        sex
        breed {
          id
          name
          kind {
            id
            name
          }
        }
        images {
          order
          image
        }
        tenureSet {
          user {
            id
            name
          }  
          role {
            id
            name
          }
        }
      }
    }
  }
  """;

}