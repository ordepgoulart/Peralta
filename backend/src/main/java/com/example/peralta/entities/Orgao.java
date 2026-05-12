package com.example.peralta.entities;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "orgaos")
public class Orgao {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "org_id")
    private Long id;

    @Column(name = "org_nome")
    private String nome;

    public Orgao(Long id, String nome) {
        this.id = id;
        this.nome = nome;
    }

    public Orgao(String nome) {
        this(0L, nome);
    }

    public Orgao() {
        this(0L, "");
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
}
