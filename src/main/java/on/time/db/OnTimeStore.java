package on.time.db;

import io.reactivex.Flowable;
import io.reactivex.Single;

public interface OnTimeStore<T> {
    Flowable<T> getAll();
    Single<T> getOne(String id);
    Flowable<Integer> insertOne(T obj);
}
