package on.time.db;

import io.reactivex.Flowable;
import io.reactivex.Single;

import io.vertx.reactivex.ext.web.RoutingContext;
import on.time.model.Tarea;

public class OnTimeTareaStore implements OnTimeStore<Tarea> {
    final private OnTimeDB db;

    public OnTimeTareaStore(OnTimeDB db) {
        this.db = db;
    }

    @Override
    public Flowable<Tarea> getAll(RoutingContext ctx) {
        return db.getConnection().select(
                "SELECT * " +
                  "FROM tarea AS t " +
                 "WHERE t.id_cliente = ?")
                .parameter(ctx.request().getHeader("subject"))
                .get(Tarea::fromResultSet);
    }

    @Override
    public Single<Tarea> getOne(RoutingContext ctx, String id) {
        return db.getConnection().select("SELECT *" +
                                           "FROM tarea AS t" +
                                          "WHERE t.id_tarea = ? " +
                                            "AND t.id_cliente = ? " +
                                          "LIMIT 1")
                .parameters(Integer.parseInt(id), ctx.request().getHeader("subject"))
                .get(Tarea::fromResultSet)
                .firstOrError();
    }

    // TODO
    @Override
    public Flowable<Integer> insertOne(RoutingContext ctx, Tarea tarea) {
        String query = "INSERT INTO tarea (id_tarea, id_cliente, id_admin, descripcion, fecha_inicio, fecha_fin, categoria)" +
                       "VALUES (?, ?, ?, ?, ?, ?, ?)";
        return db.getConnection().update(query)
                .parameters(tarea.asParameters())
                .counts();
    }
}
