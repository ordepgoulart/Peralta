package com.example.peralta.entities;


import jakarta.persistence.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name="denuncias")
public class Denuncia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "den_id")
    private Long id;

    @Column(name = "den_titulo")
    private String titulo;

    @Column(name = "den_texto")
    private String texto;

    @Column(name = "den_urgencia")
    private int urgencia;

    @Column(name = "den_data")
    private LocalDate data;

    @OneToMany(mappedBy = "denuncia", fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Foto> fotos = new ArrayList<>();

    @ManyToOne(fetch = FetchType.EAGER)
    @Column(name = "org_id")
    private Orgao orgao;

    @ManyToOne(fetch = FetchType.EAGER)
    @Column(name = "usu_id")
    private Usuario usuario;

    @ManyToOne(fetch = FetchType.EAGER)
    @Column(name = "tip_id")
    private Tipo tipo;

    public Denuncia(Long id, String titulo, String texto, int urgencia, LocalDate data, List<Foto> fotos, Orgao orgao, Usuario usuario, Tipo tipo) {
        this.id = id;
        this.titulo = titulo;
        this.texto = texto;
        this.urgencia = urgencia;
        this.data = data;
        this.fotos = fotos;
        this.orgao = orgao;
        this.usuario = usuario;
        this.tipo = tipo;
    }

    public Denuncia(Orgao orgao, Usuario usuario, Tipo tipo, LocalDate data, int urgencia, String texto, String titulo) {
        this(0L,titulo,texto,urgencia,data,new ArrayList<>(),orgao,usuario,tipo);
    }

    public Denuncia(String titulo, String texto, int urgencia, LocalDate data, List<Foto> fotos, Orgao orgao, Usuario usuario, Tipo tipo) {
        this(0L,titulo,texto,urgencia,data,fotos,orgao,usuario,tipo);
    }

    public Denuncia() {
        this(0L,"","",0,LocalDate.now(),new ArrayList<Foto>(),null,null,null);
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public int getUrgencia() {
        return urgencia;
    }

    public void setUrgencia(int urgencia) {
        this.urgencia = urgencia;
    }

    public LocalDate getData() {
        return data;
    }

    public void setData(LocalDate data) {
        this.data = data;
    }

    public List<Foto> getFotos() {
        return fotos;
    }

    public void setFotos(List<Foto> fotos) {
        this.fotos = fotos;
    }

    public void addFoto(Foto foto) {
        this.fotos.add(foto);
    }

    public void removeFoto(String arquivo) {
        Foto foto = new Foto();
        boolean remove = false;
        for (int i = 0; i < this.fotos.size() && !remove; i++) {
            foto = this.fotos.get(i);
            if(foto.getArquivo().equals(arquivo)) {
                this.fotos.remove(foto);
                remove = true;
            }
        }
    }

    public Orgao getOrgao() {
        return orgao;
    }

    public void setOrgao(Orgao orgao) {
        this.orgao = orgao;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Tipo getTipo() {
        return tipo;
    }

    public void setTipo(Tipo tipo) {
        this.tipo = tipo;
    }

    @Override
    public String toString() {
        return "Denuncia{" +
                "id=" + id +
                ", titulo='" + titulo + '\'' +
                ", texto='" + texto + '\'' +
                ", urgencia=" + urgencia +
                ", data=" + data +
                ", fotos=" + fotos +
                '}';
    }
}
