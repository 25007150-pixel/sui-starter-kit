module starter::practica_sui {
    use std::debug::print;
    use std::string::{String, utf8};

    struct Usuario {
        nombre: String,
        edad: u8,
        vivo: bool,
    }

    fun practica(usuario: Usuario) {
       
        if(edad > 18) {
         print(&utf8(b"Acceso permitido"));
    }

    #[test]
    fun prueba() {
        practica();
    }
    
}