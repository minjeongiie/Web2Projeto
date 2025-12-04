package model;

import java.time.LocalDate;
import jakarta.persistence.*;

@Entity
@Table(name = "inscricoes")
public class Inscricao {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    private Aluno aluno;

    private String tipo;   // Evento, Curso, Projeto, Programa, Servico
    private Integer extensaoId;

    private LocalDate dataInscricao;

    private String status; // “Inscrito”, “Cancelado”, etc.

    public Integer getId() { return id; }

    public Aluno getAluno() { return aluno; }
    public void setAluno(Aluno aluno) { this.aluno = aluno; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public Integer getExtensaoId() { return extensaoId; }
    public void setExtensaoId(Integer extensaoId) { this.extensaoId = extensaoId; }

    public LocalDate getDataInscricao() { return dataInscricao; }
    public void setDataInscricao(LocalDate dataInscricao) { this.dataInscricao = dataInscricao; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
