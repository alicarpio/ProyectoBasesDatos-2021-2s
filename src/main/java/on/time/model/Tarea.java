package on.time.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

public class Tarea {
    private int idTarea;
    private String idCliente;
    private String idAdmin;
    private String descripcion;
    private Date fechaInicio;
    private Date fechaFin;
    private String categoria;

    public Tarea(int idTarea, String idAdmin, String idCliente,
                 String descripcion, Date fechaInicio, Date fechaFin, String categoria) {
        this.idTarea = idTarea;
        this.idCliente = idCliente;
        this.idAdmin = idAdmin;
        this.descripcion = descripcion;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.categoria = categoria;
    }

    public static Tarea fromResultSet(ResultSet rs) throws SQLException {
        return new Tarea(rs.getInt("id_tarea"), rs.getString("id_cliente"), rs.getString("id_admin"),
                rs.getString("descripcion"), rs.getDate("fecha_inicio"),
                rs.getDate("fecha_fin"), rs.getString("categoria"));
    }

    public List<?> asParameters() {
        return List.of(idTarea, idCliente, idAdmin, descripcion, fechaInicio, fechaFin, categoria);
    }

    public int getIdTarea() {
        return idTarea;
    }

    public String getIdCliente() {
        return idCliente;
    }

    public String getIdAdmin() {
        return idAdmin;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public Date getFechaInicio() {
        return fechaInicio;
    }

    public Date getFechaFin() {
        return fechaFin;
    }

    public String getCategoria() {
        return categoria;
    }

    @Override
    public String toString() {
        return "Tarea{" +
                "idTarea=" + idTarea +
                ", idCliente='" + idCliente + '\'' +
                ", idAdmin='" + idAdmin + '\'' +
                ", descripcion='" + descripcion + '\'' +
                ", fechaInicio=" + fechaInicio +
                ", fechaFin=" + fechaFin +
                ", categorias='" + categoria + '\'' +
                '}';
    }
}

