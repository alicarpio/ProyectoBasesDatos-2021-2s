package on.time.routes;

import io.vertx.core.impl.logging.Logger;
import io.vertx.core.impl.logging.LoggerFactory;
import io.vertx.core.json.JsonObject;
import io.vertx.reactivex.core.Vertx;
import io.vertx.reactivex.ext.web.Router;
import io.vertx.reactivex.ext.web.RoutingContext;

import on.time.db.OnTimeStore;
import on.time.model.Tarea;

public class RutaTarea {
    private Router router;
    private OnTimeStore<Tarea> store;
    private static Logger logger = LoggerFactory.getLogger(RutaTarea.class);

    public RutaTarea(Vertx vertx, OnTimeStore<Tarea> store) {
        router = Router.router(vertx);
        this.store = store;

        router.get("/").handler(this::getAll);
        router.get("/:id").handler(this::getOne);
        router.post("/ingresar").handler(this::insertOne);
    }

    public Router getRouter() {
        return router;
    }

    public void getAll(RoutingContext ctx) {
        store.getAll(ctx).toList().subscribe(tareas -> {
            ctx.json(new JsonObject().put("tareas", tareas));
        });
    }

    public void getOne(RoutingContext ctx) {
        store.getOne(ctx, ctx.pathParam("id"))
                .subscribe(tarea -> {
                    logger.info("Tarea " + tarea + " sent succesfully");
                    ctx.json(JsonObject.mapFrom(tarea));
                }, err -> {
                    logger.error("Error al enviar tarea: ", err);
                    ctx.response().setStatusCode(404).end(new JsonObject()
                            .put("error", String.format("Tarea with id '%s' not found", ctx.pathParam("id")))
                            .encode());
                });
    }

    // TODO
    public void insertOne(RoutingContext ctx) {
    }
}
