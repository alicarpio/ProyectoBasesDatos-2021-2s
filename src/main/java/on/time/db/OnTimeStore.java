package on.time.db;

import io.reactivex.Flowable;

public interface OnTimeStore<T> {
    Flowable<T> getAll();
}
