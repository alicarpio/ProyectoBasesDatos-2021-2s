package on.time.db;

import io.reactivex.Flowable;
import io.reactivex.Single;
import on.time.model.Cliente;

public class OnTimeClientStore {
    final private OnTimeDB db;

    public OnTimeClientStore(OnTimeDB db) {
        this.db = db;
    }

    public Flowable<Cliente> getAll() {
        return db.getConnection()
                .select("SELECT * FROM cliente")
                .get(Cliente::fromResultSet);
    }

    public Single<Cliente> getOne(String id) {
        return db.getConnection()
                .select("SELECT * FROM cliente WHERE nombre_usuario = ? LIMIT 1")
                .parameter(id)
                .get(Cliente::fromResultSet)
                .firstOrError();
    }

    public Flowable<Integer> insertOne(Cliente cliente) {
        return db.getConnection()
                .update("INSERT INTO cliente (nombre_usuario, contrasena, nombre, apellido, correo, telefono) " +
                        "VALUES (?, ?, ?, ?, ?, ?)")
                .parameters(cliente.asParameters())
                .counts();
    }
}
