package on.time;

import io.reactivex.Completable;
import io.vertx.core.http.HttpMethod;
import io.vertx.core.impl.logging.Logger;
import io.vertx.core.impl.logging.LoggerFactory;
import io.vertx.reactivex.core.AbstractVerticle;
import io.vertx.reactivex.core.Vertx;
import io.vertx.reactivex.ext.web.Router;

import on.time.db.*;
import on.time.model.*;
import on.time.routes.RouterCliente;

public class Main extends AbstractVerticle {
    public static Logger logger = LoggerFactory.getLogger(Main.class);

    @Override
    public Completable rxStart() {
        OnTimeDB db = OnTimeDB.getInstance();
        OnTimeStore<Cliente> clientStore = new OnTimeClientStore(db);

        Router router = Router.router(vertx);

        router.route().method(HttpMethod.GET).path("/").handler(ctx -> {
            ctx.response().end("Bienvenido a nuestro proyecto!");
        });

        RouterCliente routerUsuarios = new RouterCliente(vertx, clientStore);
        router.mountSubRouter("/api/v1/usuarios", routerUsuarios.getRouter());

        return vertx.createHttpServer()
                .requestHandler(router)
                .rxListen(Integer.parseInt(System.getProperty("server.port")))
                .doOnSuccess(server -> logger.info("Server started on port " + server.actualPort()))
                .doOnError(err -> logger.error("{}", err))
                .ignoreElement();
    }

    public static void main(String[] args) {
        Vertx vertx = Vertx.vertx();
        vertx.deployVerticle(new Main(), res -> {
            if (res.succeeded())
                logger.info("Main verticle deployed");
        });
    }
}
