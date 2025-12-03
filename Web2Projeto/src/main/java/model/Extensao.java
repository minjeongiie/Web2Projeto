package model;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.MappedSuperclass;

@MappedSuperclass
public abstract class Extensao {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String titulo;
    @Column(columnDefinition = "TEXT")
    private String descricao;
    
    private String responsavel;

    private String local;
    
    private String contatoInscricao;
    private String linkExterno;
    private String status;
    private LocalDate dataInicio;
    private LocalDate dataFim;
    private String publicoAlvo;
    private boolean temTaxa;
	public Extensao() {}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public String getResponsavel() {
		return responsavel;
	}

	public void setResponsavel(String responsavel) {
		this.responsavel = responsavel;
	}

	public String getLocal() {
	    return local;
	}

	public void setLocal(String local) {
	    this.local = local;
	}

	public String getContatoInscricao() {
		return contatoInscricao;
	}

	public void setContatoInscricao(String contatoInscricao) {
		this.contatoInscricao = contatoInscricao;
	}

	public String getLinkExterno() {
		return linkExterno;
	}

	public void setLinkExterno(String linkExterno) {
		this.linkExterno = linkExterno;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public LocalDate getDataInicio() {
		return dataInicio;
	}

	public void setDataInicio(LocalDate dataInicio) {
		this.dataInicio = dataInicio;
	}

	public LocalDate getDataFim() {
		return dataFim;
	}

	public void setDataFim(LocalDate dataFim) {
		this.dataFim = dataFim;
	}

	public String getPublicoAlvo() {
		return publicoAlvo;
	}

	public void setPublicoAlvo(String publicoAlvo) {
		this.publicoAlvo = publicoAlvo;
	}

	public boolean isTemTaxa() {
		return temTaxa;
	}

	public void setTemTaxa(boolean temTaxa) {
		this.temTaxa = temTaxa;
	}

}