package on.time.model;

import com.lambdaworks.crypto.SCryptUtil;
import io.vertx.core.json.JsonObject;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public class Cliente {
    private String nombreUsuario;
    private String contrasena;
    private String nombre;
    private String apellido;
    private String correo;
    private String telefono;

    public Cliente(String nombreUsuario, String contrasena,
                   String nombre, String apellido, String correo, String telefono) {
        this.nombreUsuario = nombreUsuario;
        this.contrasena = contrasena;
        this.nombre = nombre;
        this.apellido = apellido;
        this.correo = correo;
        this.telefono = telefono;
    }

    public static Optional<Cliente> fromJson(JsonObject body) {
        var nombreUsuario = body.getString("usuario");
        var contrasena = body.getString("contrasena");
        var nombre = body.getString("nombre");
        var apellido = body.getString("apellido");
        var correo = body.getString("correo");
        var telefono = body.getString("telefono");

        if (nombreUsuario == null || contrasena == null || nombre == null
                || apellido == null || correo == null || telefono == null) {
            return Optional.empty();
        }

        // Magic numbers taken from Api Security in Action
        contrasena = SCryptUtil.scrypt(contrasena, 32768, 8, 1);

        return Optional.of(new Cliente(nombreUsuario, contrasena, nombre,
                apellido, correo, telefono));
    }

    public static Cliente fromResultSet(ResultSet rs) throws SQLException {
        return new Cliente(rs.getString("nombre_usuario"), rs.getString("contrasena"),
                rs.getString("nombre"), rs.getString("apellido"), rs.getString("correo"),
                rs.getString("telefono"));
    }

    public List<?> asParameters() {
        return List.of(nombreUsuario, contrasena, nombre, apellido, correo, telefono);
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public String getContrasena() {
        return contrasena;
    }

    public String getNombre() {
        return nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public String getCorreo() {
        return correo;
    }

    public String getTelefono() {
        return telefono;
    }

    @Override
    public String toString() {
        return "Client{" +
                "nombreUsuario='" + nombreUsuario + '\'' +
                ", nombre='" + nombre + '\'' +
                ", apellido='" + apellido + '\'' +
                ", correo='" + correo + '\'' +
                ", telefono='" + telefono + '\'' +
                '}';
    }
}
