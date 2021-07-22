package on.time.auth;

import com.lambdaworks.crypto.SCryptUtil;
import io.vertx.core.json.JsonObject;
import io.vertx.reactivex.ext.web.RoutingContext;
import on.time.db.OnTimeStore;
import on.time.model.Cliente;

import java.util.Base64;

public class UserAuth {
    private OnTimeStore<Cliente> db;

    public UserAuth(OnTimeStore<Cliente> db) {
        this.db = db;
    }

    public boolean validateUser(RoutingContext ctx, String username, String password) {
        Cliente user = db.getOne(ctx, username).blockingGet();
        return SCryptUtil.check(password, user.getContrasena());
    }

    public void parseBasicHttpAuth(RoutingContext ctx) {
        String auth = ctx.request().getHeader("Authorization");
        if (auth == null || !auth.startsWith("Basic ")) {
            ctx.response().setStatusCode(401)
                    .putHeader("WWW-Authenticate", "Basic realm=\"/\", charset=\"UTF-8\"")
                    .end();
        } else {
            int offset = "Basic ".length();
            String[] credentials = new String(Base64.getDecoder().decode(auth.substring(offset))).split(":", 2);

            String username = credentials[0];
            String contrasena = credentials[1];

            if (validateUser(ctx, username, contrasena)) {
                ctx.request().headers().add("subject", auth.substring("Basic ".length()));
                ctx.next();
            } else {
                ctx.response().setStatusCode(404).end(new JsonObject().put("error", "User does not exist").encode());
            }
        }
    }
}
