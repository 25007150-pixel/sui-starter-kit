module starter::archivo {
    use sui::vec_map::{Self, VecMap};
    use std::string::String;

    public struct Archivo has key, store {
        id: UID,
        documentos: VecMap<u64, Documento>,
    }

    public struct Documento has copy, drop, store {
        nombre: String,
        propietario: String,
        fecha_creacion: u16,
        activo: bool,
    }

    const ID_DUPLICADO: u64 = 100;
    const ID_NO_ENCONTRADO: u64 = 101;

    public fun crear_archivo(ctx: &mut TxContext) {
        let documentos = vec_map::empty();
        let archivo = Archivo {
            id: object::new(ctx),
            documentos,
        };
        transfer::transfer(archivo, tx_context::sender(ctx));
    }

    public fun agregar_documento(archivo: &mut Archivo, id: u64, nombre: String, propietario: String, fecha_creacion: u16, activo: bool) {
        assert!(!archivo.documentos.contains(&id), ID_DUPLICADO);
        let doc = Documento { nombre, propietario, fecha_creacion, activo };
        archivo.documentos.insert(id, doc);
    }

    public fun actualizar_nombre(archivo: &mut Archivo, id: u64, nombre: String) {
        assert!(archivo.documentos.contains(&id), ID_NO_ENCONTRADO);
        let nombre_actual = &mut archivo.documentos.get_mut(&id).nombre;
        *nombre_actual = nombre;
    }

    // ... funciones similares para actualizar propietario, fecha_creacion y activo

    public fun eliminar_documento(archivo: &mut Archivo, id: u64) {
        assert!(archivo.documentos.contains(&id), ID_NO_ENCONTRADO);
        archivo.documentos.remove(&id);
    }

    public fun eliminar_archivo(archivo: Archivo) {
        let Archivo { id, documentos: _ } = archivo;
        id.delete();
    }
}