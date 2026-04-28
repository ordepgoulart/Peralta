package com.example.peralta.entities;

import jakarta.persistence.*;

@Entity
@Table(name="feedback")
public class Feedback {

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="fee_id")
    private Long id;

    @Column(name="fee_texto")
    private String texto;

    //@ManyToOne()
}
