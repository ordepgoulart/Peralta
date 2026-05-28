package com.example.peralta.services;

import com.example.peralta.entities.Denuncia;
import com.example.peralta.entities.Foto;
import com.example.peralta.repositories.DenunciaRepository;
import com.example.peralta.repositories.FotoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class DenunciaService
{
    @Autowired
    private DenunciaRepository denunciaRepository;

    @Autowired
    private FotoRepository fotoRepository;

    public List<Denuncia> findAll()
    {
        return denunciaRepository.findAll();
    }

    public Denuncia findById(Long id)
    {
        return denunciaRepository.findById(id).orElse(null);
    }

    public Denuncia save(Denuncia denuncia)
    {
        try
        {
            if (denuncia.getFotos() != null)
            {
                for (Foto foto : denuncia.getFotos())
                {
                    foto.setDenuncia(denuncia);
                }
            }
            return denunciaRepository.save(denuncia);
        }
        catch (Exception e)
        {
            return null;
        }
    }

    public boolean delete(Long id)
    {
        if (findById(id) == null)
        {
            return false;
        }
        else
        {
            denunciaRepository.deleteById(id);
            return true;
        }
    }

    public List<Denuncia> findByUser(Long id)
    {
        return denunciaRepository.getByUserId(id);
    }
}