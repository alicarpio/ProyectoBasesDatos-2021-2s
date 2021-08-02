package on.time.db;

import io.reactivex.Flowable;
import io.reactivex.Single;

import io.vertx.reactivex.ext.web.RoutingContext;
import on.time.model.Cliente;

public class OnTimeClientStore implements OnTimeStore<Cliente> {
    final private OnTimeDB db;

    public OnTimeClientStore(OnTimeDB db) {
        this.db = db;
    }

    @Override
    public Flowable<Cliente> getAll(RoutingContext ctx) {
        return db.getConnection()
                .select("SELECT * FROM cliente")
                .get(Cliente::fromResultSet);
    }

    @Override
    public Single<Cliente> getOne(RoutingContext ctx, String id) {
        return db.getConnection()
                .select("SELECT * FROM cliente WHERE nombre_usuario = ? LIMIT 1")
                .parameter(id)
                .get(Cliente::fromResultSet)
                .firstOrError();
    }

    @Override
    public Flowable<Integer> insertOne(RoutingContext ctx, Cliente cliente) {
        return db.getConnection()
                .update("INSERT INTO cliente (nombre_usuario, contrasena, nombre, apellido, correo, telefono) " +
                        "VALUES (?, ?, ?, ?, ?, ?)")
                .parameters(cliente.asParameters())
                .counts();
    }
}
