package on.time.routes;

import io.vertx.core.impl.logging.Logger;
import io.vertx.core.impl.logging.LoggerFactory;
import io.vertx.core.json.Json;
import io.vertx.core.json.JsonObject;
import io.vertx.reactivex.core.Vertx;
import io.vertx.reactivex.ext.web.Router;
import io.vertx.reactivex.ext.web.RoutingContext;

import on.time.db.OnTimeStore;
import on.time.model.Cliente;

public class RutaCliente {
    private Router router;
    private OnTimeStore<Cliente> store;
    private static Logger logger = LoggerFactory.getLogger(RutaCliente.class);

    public RutaCliente(Vertx vertx, OnTimeStore<Cliente> store) {
        router = Router.router(vertx);
        this.store = store;

        router.get("/").handler(this::getAll);
        router.get("/:id").handler(this::getOne);
        router.post("/registrar").handler(this::insertOne);
    }

    public Router getRouter() {
        return router;
    }

    public void getAll(RoutingContext ctx) {
        store.getAll().toList().subscribe(
                clientes -> ctx.json(new JsonObject().put("clientes", clientes)),
                err -> logger.error("{}", err));
    }

    public void getOne(RoutingContext ctx) {
        store.getOne(ctx.pathParam("id")).subscribe(
                cliente -> ctx.json(new JsonObject().put("cliente", cliente)),
                err -> ctx.response().setStatusCode(404).end(new JsonObject().put("error", "No such cliente").encode()));
    }

    public void insertOne(RoutingContext ctx) {
        Cliente.fromJson(ctx.getBodyAsJson()).ifPresentOrElse(cliente -> {
            store.insertOne(cliente).subscribe(
                    i -> ctx.response().setStatusCode(201).end(new JsonObject().put("updated", i).encode()),
                    err -> ctx.response().setStatusCode(409).end(new JsonObject().put("error", "Username already taken").encode()));
        }, () -> ctx.response().setStatusCode(400).end(new JsonObject().put("error", "Missing fields").encode()));
    }
}
