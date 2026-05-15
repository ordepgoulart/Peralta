package com.example.peralta.services;

import com.example.peralta.entities.Tipo;
import com.example.peralta.repositories.TipoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
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

    public Tipo findById(Long id){
        Tipo tipo = tipoRepository.findById(id).orElse(null);
        return tipo;
    }

    public List<Tipo> findByName(String name){
        List<Tipo> tipos = tipoRepository.findByName(name);
        return tipos;
    }

    public Tipo save(Tipo tipo){
        Tipo newTipo;
        try
        {
            newTipo = tipoRepository.save(tipo);
        }
        catch (Exception e)
        {
            newTipo = null;
        }
        return newTipo;
    }

    public boolean delete(Long id){
        if(findById(id) == null)
            return false;
        else
        {
            tipoRepository.deleteById(id);
            return true;
        }
    }
}
