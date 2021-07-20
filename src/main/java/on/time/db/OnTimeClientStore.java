package on.time.db;

import io.reactivex.Flowable;

import on.time.model.Cliente;

public class OnTimeClientStore implements OnTimeStore<Cliente> {
    final private OnTimeDB db;

    public OnTimeClientStore(OnTimeDB db) {
        this.db = db;
    }

    @Override
    public Flowable<Cliente> getAll() {
        return db.getConnection().select("SELECT * FROM cliente")
                .getAs(String.class, String.class, String.class,
                        String.class, String.class, String.class)
                .map(tuple -> new Cliente(tuple._1(), null, tuple._3(),
                        tuple._4(), tuple._5(), tuple._6()));
    }

    @Override
    public Flowable<Integer> insertOne(Cliente cliente) {
        return db.getConnection()
                .update("INSERT INTO cliente (nombre_usuario, contrasena, nombre, apellido, correo, telefono) " +
                        "VALUES (?, ?, ?, ?, ?, ?)")
                .parameters(cliente.getNombreUsuario(), cliente.getContrasena(), cliente.getNombre(),
                        cliente.getApellido(), cliente.getCorreo(), cliente.getTelefono())
                .counts();
    }
}
