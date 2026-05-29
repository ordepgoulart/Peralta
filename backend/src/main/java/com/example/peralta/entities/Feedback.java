package com.example.peralta.entities;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;

@Entity
@Table(name="feedbacks")
public class Feedback
{
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="fee_id")
    private Long id;

    @Column(name="fee_texto")
    private String texto;

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "den_id")
    private Denuncia denuncia;

    public Feedback(Long id, String texto, Denuncia denuncia)
    {
        this.id = id;
        this.texto = texto;
        this.denuncia = denuncia;
    }

    public Feedback(String texto, Denuncia denuncia)
    {
        this(0L, texto, denuncia);
    }

    public Feedback()
    {
        this(0L, "", null);
    }

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public String getTexto()
    {
        return texto;
    }

    public void setTexto(String texto)
    {
        this.texto = texto;
    }

    public Denuncia getDenuncia()
    {
        return denuncia;
    }

    public void setDenuncia(Denuncia denuncia)
    {
        this.denuncia = denuncia;
    }
}