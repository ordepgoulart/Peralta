package com.example.peralta.services;

import com.example.peralta.entities.Orgao;
import com.example.peralta.entities.Tipo;
import com.example.peralta.repositories.OrgaoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrgaoService {
    @Autowired
    private OrgaoRepository orgaoRepository;

    public List<Orgao> findAll()
    {
        List<Orgao> orgaos = orgaoRepository.findAll();
        return orgaos;
    }

    public Orgao findById(Long id){
        Orgao orgao = orgaoRepository.findById(id).orElse(null);
        return orgao;
    }

    public List<Orgao> findByName(String name){
        List<Orgao> orgaos = orgaoRepository.findByNome(name);
        return orgaos;
    }

    public Orgao save(Orgao orgao){
        Orgao newOrgao;
        try
        {
            newOrgao = orgaoRepository.save(orgao);
        }
        catch (Exception e)
        {
            newOrgao = null;
        }
        return newOrgao;
    }

    public boolean delete(Long id){
        if(findById(id) == null)
            return false;
        else
        {
            orgaoRepository.deleteById(id);
            return true;
        }
    }
}
