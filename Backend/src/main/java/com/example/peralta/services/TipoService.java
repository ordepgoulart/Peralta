package com.example.peralta.services;

import com.example.peralta.entities.Tipo;
import com.example.peralta.repositories.TipoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TipoService {
    @Autowired
    private TipoRepository tipoRepository;

    public List<Tipo> findAll(){
        List<Tipo> listaTipo = tipoRepository.findAll();
        return listaTipo;
    }
}
