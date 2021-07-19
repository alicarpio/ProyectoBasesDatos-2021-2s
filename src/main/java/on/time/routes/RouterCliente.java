package on.time.routes;

import io.vertx.core.impl.logging.Logger;
import io.vertx.core.impl.logging.LoggerFactory;
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
                    .end(responseObj.encode());
        }, err -> logger.error("{}", err));
    }
}
