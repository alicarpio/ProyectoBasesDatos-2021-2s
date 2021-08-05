package on.time.db;

import io.reactivex.Flowable;
import io.reactivex.Single;
import on.time.model.Tarea;

public class OnTimeTareaStore {
    final private OnTimeDB db;

    public OnTimeTareaStore(OnTimeDB db) {
        this.db = db;
    }

    public Flowable<Tarea> getAll(String subject) {
        return db.getConnection()
                .select("SELECT * FROM tarea WHERE id_cliente = ?")
                .parameter(subject)
                .get(Tarea::fromResultSet);
    }

    public Single<Tarea> getOne(String subject, String id) {
        return db.getConnection().select("SELECT *" +
                        "FROM tarea AS t" +
                        "WHERE t.id_tarea = ? " +
                        "AND t.id_cliente = ? " +
                        "LIMIT 1")
                .parameters(Integer.parseInt(id), subject)
                .get(Tarea::fromResultSet)
                .firstOrError();
    }

    // TODO
    public Flowable<Integer> insertOne(String subject, Tarea tarea) {
        return db.getConnection()
                .update("INSERT INTO tarea (id_tarea, id_cliente, id_admin, descripcion, fecha_inicio, fecha_fin, categoria)" +
                        "VALUES (?, ?, ?, ?, ?, ?, ?)")
                .parameters(tarea.asParameters())
                .counts();
    }
}
