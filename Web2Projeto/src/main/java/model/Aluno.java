package model;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Entity
@DiscriminatorValue("1")
public class Aluno extends Pessoa {

    private Integer matricula;

    public Aluno() {}

    public Aluno(String nome, String email, String senha, Integer matricula) {
        super(nome, email, senha);
        this.matricula = matricula;
    }

    public Integer getMatricula() {
        return matricula;
    }

    public void setMatricula(Integer matricula) {
        this.matricula = matricula;
    }
}
