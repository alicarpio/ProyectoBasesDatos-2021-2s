package on.time.routes;

import io.vertx.core.impl.logging.Logger;
import io.vertx.core.impl.logging.LoggerFactory;
import io.vertx.core.json.JsonObject;
import io.vertx.reactivex.core.Vertx;
import io.vertx.reactivex.ext.web.Router;
import io.vertx.reactivex.ext.web.RoutingContext;
import on.time.db.OnTimeTareaStore;
import on.time.model.Tarea;

import java.util.List;

public class RutaTarea {
    private Router router;
    private OnTimeTareaStore store;
    private static Logger logger = LoggerFactory.getLogger(RutaTarea.class);

    public RutaTarea(Vertx vertx, OnTimeTareaStore store) {
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
        List<Tarea> tareas = store.getAll(ctx.pathParam("subject")).toList().blockingGet();
        ctx.json(new JsonObject().put("tareas", tareas));
    }

    public void getOne(RoutingContext ctx) {
        try {
            Tarea tarea = store.getOne(ctx.pathParam("subject"), ctx.pathParam("id")).blockingGet();
            logger.info("Tarea " + tarea + " sent succesfully");
            ctx.json(JsonObject.mapFrom(tarea));
        } catch (Exception e) {
            logger.error("Error al enviar tarea: ", e);
            ctx.response().setStatusCode(404).end(new JsonObject()
                    .put("error", String.format("Tarea with id '%s' not found", ctx.pathParam("id")))
                    .encode());
        }
    }

    // TODO
    public void insertOne(RoutingContext ctx) {
    }
}
