package com.example.peralta.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "fotos")
public class Foto
{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "foto_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "den_id")
    private Denuncia denuncia;

    @Column(name = "foto_arq")
    private String arquivo;

    public Foto(Long id, Denuncia denuncia, String arquivo)
    {
        this.id = id;
        this.denuncia = denuncia;
        this.arquivo = arquivo;
    }

    public Foto(String arquivo)
    {
        this(null, null, arquivo);
    }

    public Foto(Denuncia denuncia, String arquivo)
    {
        this(null, denuncia, arquivo);
    }

    public Foto()
    {
        this(null, null, "");
    }

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public void setDenuncia(Denuncia denuncia)
    {
        this.denuncia = denuncia;
    }

    public String getArquivo()
    {
        return arquivo;
    }

    public void setArquivo(String arquivo)
    {
        this.arquivo = arquivo;
    }

    @Override
    public String toString()
    {
        return "Foto{" +
                "id=" + id +
                ", arquivo='" + arquivo + '\'' +
                '}';
    }
}