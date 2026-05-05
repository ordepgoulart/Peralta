package com.example.peralta.services;

import com.example.peralta.entities.Usuario;
import com.example.peralta.repositories.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UsuarioService {
    @Autowired
    private UsuarioRepository usuarioRepository;

    public List<Usuario> findAll() {
        List<Usuario> usuarios = usuarioRepository.findAll();
        return usuarios;
    }

    public Usuario findById(Long id) {
        Usuario usuario = usuarioRepository.findById(id).orElse(null);
        return usuario;
    }

    public Usuario save(Usuario usuario) {
        Usuario newUser;
        try {
            newUser = usuarioRepository.save(usuario);
        }
        catch (Exception e) {
            newUser = null;
        }
        return newUser;
    }

    public boolean delete(Long id) {
        if(findById(id) == null) {
            return false;
        }
        else  {
            usuarioRepository.deleteById(id);
            return true;
        }
    }

    public Usuario findByKeyAccess(String key) {
        Usuario usuario = usuarioRepository.findByKeyAccess(key);
        return usuario;
    }
}
