package model;

import java.time.Duration;
import java.time.LocalTime;

public class Evento extends Extensao {
	private int maxParticipantes;
	private LocalTime horaDeInicio;
	private LocalTime horadeTermino;
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
		setCargaHoraria();
	}

	public LocalTime getHoradeTermino() {
		return horadeTermino;
	}

	public void setHoradeTermino(LocalTime horadeTermino) {
		this.horadeTermino = horadeTermino;
		setCargaHoraria();
	}

	public double getCargaHoraria() {
		return cargaHoraria;
		
	}

	private void setCargaHoraria() {
		Duration duracao = Duration.between(horaDeInicio, horadeTermino);
		long cargaHorariaEmHoras = duracao.toMinutes()/60;
		this.cargaHoraria = cargaHorariaEmHoras;
	}

}