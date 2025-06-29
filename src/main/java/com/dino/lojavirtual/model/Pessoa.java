package com.dino.lojavirtual.model;

import jakarta.persistence.*;

import java.io.Serializable;

@MappedSuperclass
public abstract class Pessoa implements Serializable {

    private String nome;

    private String email;

    private String telefone;

    public Pessoa() {}

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }
}
