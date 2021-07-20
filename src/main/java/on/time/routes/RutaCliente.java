package on.time.routes;

import io.vertx.core.impl.logging.Logger;
import io.vertx.core.impl.logging.LoggerFactory;
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

        router.get().handler(this::getAll);
        router.post("/crear").handler(this::insertOne);
    }

    public Router getRouter() {
        return router;
    }

    public void getAll(RoutingContext ctx) {
        store.getAll().toList().subscribe(xs -> {
            JsonObject responseObj = new JsonObject().put("clientes", xs);
            ctx.rxJson(responseObj).subscribe(
                    () -> logger.info("Client sent succesfully"),
                    err -> logger.error("{}", err));
        }, err -> logger.error("{}", err));
    }

    public void insertOne(RoutingContext ctx) {
        Cliente.fromJson(ctx.getBodyAsJson()).ifPresentOrElse(cliente -> {
                    store.insertOne(cliente).subscribe(i -> {
                        var res = new JsonObject().put("updated", i);
                        ctx.rxJson(res).subscribe(
                                () -> logger.info("Client inserted, updated " + i + "records"),
                                err -> logger.error("Failed to insert new client: {}", err));
                    });
                }, () -> ctx
                        .response()
                        .setStatusCode(401)
                        .rxEnd(new JsonObject().put("error", "Missing fields").encode())
                        .subscribe()
        );
    }
}
