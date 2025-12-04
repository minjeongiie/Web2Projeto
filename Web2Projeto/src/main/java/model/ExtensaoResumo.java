package model;

public class ExtensaoResumo {

    private Integer id;
    private String titulo;
    private String tipo;  // EVENTO, CURSO, SERVICO, PROJETO, PROGRAMA
    private String dataInicio;
    private String dataFim;
    private String status;

    public ExtensaoResumo(Integer id, String titulo, String tipo, 
                          String dataInicio, String dataFim, String status) {

        this.id = id;
        this.titulo = titulo;
        this.tipo = tipo;
        this.dataInicio = dataInicio;
        this.dataFim = dataFim;
        this.status = status;
    }

    public Integer getId() { return id; }
    public String getTitulo() { return titulo; }
    public String getTipo() { return tipo; }
    public String getDataInicio() { return dataInicio; }
    public String getDataFim() { return dataFim; }
    public String getStatus() { return status; }
}