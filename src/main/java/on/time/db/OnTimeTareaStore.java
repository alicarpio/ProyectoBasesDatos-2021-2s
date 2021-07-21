package on.time.db;

import io.reactivex.Flowable;
import io.reactivex.Single;

import on.time.model.Tarea;

public class OnTimeTareaStore implements OnTimeStore<Tarea> {
    final private OnTimeDB db;

    public OnTimeTareaStore(OnTimeDB db) {
        this.db = db;
    }

    @Override
    public Flowable<Tarea> getAll() {
        return db.getConnection().select("SELECT * FROM tarea").get(Tarea::fromResultSet);
    }

    @Override
    public Single<Tarea> getOne(String id) {
        return db.getConnection().select("SELECT * FROM tarea WHERE id_tarea = ? LIMIT 1")
                .parameter(Integer.parseInt(id))
                .get(Tarea::fromResultSet)
                .firstOrError();
    }

    @Override
    public Flowable<Integer> insertOne(Tarea tarea) {
        String query = "INSERT INTO tarea (id_tarea, id_cliente, id_admin, descripcion, fecha_inicio, fecha_fin, categoria)" +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        return db.getConnection().update(query)
                .parameters(tarea.asParameters())
                .counts();
    }
}
