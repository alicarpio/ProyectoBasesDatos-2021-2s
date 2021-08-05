package on.time.routes;

import io.vertx.core.impl.logging.Logger;
import io.vertx.core.impl.logging.LoggerFactory;
import io.vertx.core.json.JsonObject;
import io.vertx.reactivex.core.Vertx;
import io.vertx.reactivex.ext.web.Router;
import io.vertx.reactivex.ext.web.RoutingContext;
import on.time.db.OnTimeClientStore;
import on.time.model.Cliente;

import java.util.NoSuchElementException;

public class RutaCliente {
    private Router router;
    private OnTimeClientStore store;
    private static Logger logger = LoggerFactory.getLogger(RutaCliente.class);

    public RutaCliente(Vertx vertx, OnTimeClientStore store) {
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
                err -> {
                    logger.error("Error while fetching single user: ", err);
                    ctx.response().setStatusCode(404).end(new JsonObject().put("error", "No such cliente").encode());
                });
    }

    public void insertOne(RoutingContext ctx) {
        Cliente cliente = Cliente.fromJson(ctx.getBodyAsJson()).orElse(null);

        if (cliente == null) {
            logger.error("Error while converting from json to user: ");
            ctx.response().setStatusCode(400).end(new JsonObject().put("error", "Missing fields").encode());
        }

        try {
            int updated = store.insertOne(cliente).blockingFirst();
            ctx.response().setStatusCode(201).end(new JsonObject().put("updated", updated).encode());
        } catch (NoSuchElementException e) {
            logger.error("Error while inserting new user: ", e);
            ctx.response().setStatusCode(409)
                    .end(new JsonObject().put("error", "Username already taken").encode());
        }
    }
}
