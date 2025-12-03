package model;

import java.time.Duration;
import java.time.LocalTime;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "evento")
public class Evento extends Extensao {

    private int maxParticipantes;

    private LocalTime horaDeInicio;
    private LocalTime horaDeTermino;

    private double cargaHoraria;
    
	public Evento() {
	}

	public int getMaxParticipantes() {
		return maxParticipantes;
	}

	public void setMaxParticipantes(int maxParticipantes) {
		this.maxParticipantes = maxParticipantes;
	}

	public LocalTime getHoraDeInicio() {
		return horaDeInicio;
	}

	public void setHoraDeInicio(LocalTime horaDeInicio) {
        this.horaDeInicio = horaDeInicio;
        calcularCargaHoraria();
    }

	public LocalTime getHoradeTermino() {
		return horaDeTermino;
	}

	public void setHoraDeTermino(LocalTime horaDeTermino) {
        this.horaDeTermino = horaDeTermino;
        calcularCargaHoraria();
    }

	public double getCargaHoraria() {
		return cargaHoraria;
		
	}

	private void calcularCargaHoraria() {
        if (horaDeInicio != null && horaDeTermino != null) {
            Duration duracao = Duration.between(horaDeInicio, horaDeTermino);
            this.cargaHoraria = duracao.toMinutes() / 60.0;
        }
    }

}