package model;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Entity
@DiscriminatorValue("2")
public class Professor extends Pessoa {

    private Integer siape;

    public Professor() {}

    public Professor(String nome, String email, String senha, Integer siape) {
        super(nome, email, senha);
        this.siape = siape;
    }

    public Integer getSiape() {
        return siape;
    }

    public void setSiape(Integer siape) {
        this.siape = siape;
    }
}
