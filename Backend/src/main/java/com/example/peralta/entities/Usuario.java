package com.example.peralta.entities;

import jakarta.persistence.*;

@Id
@Table(name = "usuario")
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "usu_id")
    private Long id;

    @Column(name = "usu_cpf")
    private String cpf;

    @Column(name="usu_email")
    private String email;

    @Column(name = "usu_nivel")
    private int acesso;

    @Column(name = "usu_senha")
    private String senha;


    public Usuario(Long id, String cpf, String email, int acesso, String senha) {
        this.id = id;
        this.cpf = cpf;
        this.email = email;
        this.acesso = acesso;
        this.senha = senha;
    }

    public Usuario(String cpf, String email, int acesso, String senha) {
       this(0L, cpf, email, acesso,senha);
    }

    public Usuario() {
        this(0L, "", "", 0, "");
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getAcesso() {
        return acesso;
    }

    public void setAcesso(int acesso) {
        this.acesso = acesso;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }
}
