package on.time.db;

import io.reactivex.Flowable;
import io.reactivex.Single;
import io.vertx.reactivex.ext.web.RoutingContext;

public interface OnTimeStore<T> {
    Flowable<T> getAll(RoutingContext ctx);
    Single<T> getOne(RoutingContext ctx, String id);
    Flowable<Integer> insertOne(RoutingContext ctx, T obj);
}
