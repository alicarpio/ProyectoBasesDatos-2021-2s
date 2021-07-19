package on.time.db;

import io.reactivex.Flowable;

import on.time.model.Client;

public class OnTimeClientStore implements OnTimeStore<Client> {
    final private OnTimeDB db;

    public OnTimeClientStore(OnTimeDB db) {
        this.db = db;
    }

    @Override
    public Flowable<Client> getAll() {
        return db.getConnection().select("select * from cliente")
                .getAs(String.class, String.class, String.class, String.class,
                        String.class, String.class)
                .map(tuple -> new Client(tuple._1(), tuple._3(), tuple._4(),
                        tuple._5(), tuple._6()));
    }
}
