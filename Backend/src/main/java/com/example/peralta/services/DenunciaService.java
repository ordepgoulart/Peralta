package com.example.peralta.services;

import com.example.peralta.entities.Denuncia;
import com.example.peralta.entities.Foto;
import com.example.peralta.entities.Tipo;
import com.example.peralta.repositories.DenunciaRepository;
import com.example.peralta.repositories.FotoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DenunciaService {
    @Autowired
    private DenunciaRepository denunciaRepository;

    @Autowired
    private FotoRepository fotoRepository;

    public List<Denuncia> findAll() {
        List<Denuncia> denuncias = denunciaRepository.findAll();
        return denuncias;
    }

    public Denuncia findById(Long id) {
        Denuncia denuncia = denunciaRepository.findById(id).orElse(null);
        return denuncia;
    }

    public Denuncia save(Denuncia denuncia) {
        Denuncia newDenuncia;
        try {
            if(denuncia.getId()==null){
                newDenuncia = denunciaRepository.save(denuncia);
                for(Foto foto : denuncia.getFotos()){
                    foto.setDenuncia(newDenuncia);
                    fotoRepository.save(foto);
                }
            }
            else
            {
                denunciaRepository.delete(denuncia);
                newDenuncia = denunciaRepository.save(denuncia);
                for(Foto foto : denuncia.getFotos()){
                    foto.setDenuncia(newDenuncia);
                    fotoRepository.save(foto);
                }
            }

        }
        catch (Exception e){
            System.out.println(e.getMessage());
            newDenuncia = null;
        }
        return newDenuncia;
    }

    public boolean delete(Long id)
    {
        if(findById(id) == null)
            return false;
        else
        {
            denunciaRepository.deleteById(id);
            return true;
        }
    }

    public List<Denuncia> findByUser(Long id) {
        List<Denuncia> denuncias = denunciaRepository.getByUserId(id);
        return denuncias;
    }
}
