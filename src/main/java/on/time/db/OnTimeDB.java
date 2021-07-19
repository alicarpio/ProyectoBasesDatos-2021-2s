package on.time.db;

import org.davidmoten.rx.jdbc.ConnectionProvider;
import org.davidmoten.rx.jdbc.Database;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class OnTimeDB {
    final private Database db;
    private static OnTimeDB instance;

    private OnTimeDB() throws SQLException, URISyntaxException {
        URI dbUri = new URI(System.getenv("DATABASE_URL"));

        String username = dbUri.getUserInfo().split(":")[0];
        String password = dbUri.getUserInfo().split(":")[1];
        String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath();

        Connection conn = DriverManager.getConnection(dbUrl, username, password);
        db = Database.fromBlocking(ConnectionProvider.from(conn));
    }

    public static OnTimeDB getInstance() {
        if (instance == null) {
            try {
                instance = new OnTimeDB();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return instance;
    }

    public Database getConnection() {
        return db;
    }
}
