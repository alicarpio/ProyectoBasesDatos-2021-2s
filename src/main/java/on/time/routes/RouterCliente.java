package on.time.routes;

import io.vertx.core.impl.logging.Logger;
import io.vertx.core.impl.logging.LoggerFactory;
import io.vertx.core.json.JsonArray;
import io.vertx.core.json.JsonObject;
import io.vertx.reactivex.core.Vertx;
import io.vertx.reactivex.core.http.HttpServerResponse;
import io.vertx.reactivex.ext.web.Router;
import io.vertx.reactivex.ext.web.RoutingContext;

import on.time.db.OnTimeStore;
import on.time.model.Cliente;

import java.util.ArrayList;

public class RouterCliente {
    private Router router;
    private OnTimeStore<Cliente> store;
    private static Logger logger = LoggerFactory.getLogger(RouterCliente.class);

    public RouterCliente(Vertx vertx, OnTimeStore<Cliente> store) {
        router = Router.router(vertx);
        this.store = store;

        router.get().handler(this::getAll);
        router.post("/crear").handler(this::insertOne);
    }

    public Router getRouter() {
        return router;
    }

    public void getAll(RoutingContext ctx) {
        store.getAll().reduce(new ArrayList<Cliente>(), (xs, x) -> {
            xs.add(x);
            return xs;
        }).subscribe(xs -> {
            HttpServerResponse response = ctx.response();
            JsonObject responseObj = new JsonObject()
                    .put("clientes", xs);
            response.putHeader("Content-Type", "application/json")
                    .rxEnd(responseObj.encode())
                    .subscribe(() -> logger.info("Client sent succesfully"),
                            err -> logger.error("{}", err));
        }, err -> logger.error("{}", err));
    }

    public void insertOne(RoutingContext ctx) {
        var req = ctx.getBodyAsJson();

        var nombreUsuario = req.getString("usuario");
        var contrasena = req.getString("contrasena");
        var nombre = req.getString("nombre");
        var apellido = req.getString("apellido");
        var correo = req.getString("correo");
        var telefono = req.getString("telefono");

        if (nombreUsuario == null || contrasena == null || nombre == null ||
                apellido == null || correo == null || telefono == null) {
            ctx.response()
                    .setStatusCode(401)
                    .rxEnd(new JsonObject().put("error", "Missing fields").encode())
                    .subscribe();
        }

        Cliente cliente = new Cliente(
                nombreUsuario, contrasena, nombre,
                apellido, correo, telefono);

        store.insertOne(cliente).subscribe(i -> {
            var res = new JsonObject().put("updated", i);
            ctx.rxJson(res).subscribe(
                    () -> logger.info("Client inserted, updated " + i + "records"),
                    err -> logger.error("Failed to insert new client: {}", err));
        });
    }
}
