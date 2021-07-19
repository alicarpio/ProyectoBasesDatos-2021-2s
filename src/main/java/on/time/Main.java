package on.time;

import on.time.db.*;
import on.time.model.*;

public class Main {
    public static void main(String[] args) {
        OnTimeDB db = OnTimeDB.getInstance();
        OnTimeStore<Client> clientStore = new OnTimeClientStore(db);

        clientStore.getAll()
                .blockingForEach(System.out::println);
    }
}
