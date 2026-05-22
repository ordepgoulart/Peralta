package com.example.peralta.repositories;

import com.example.peralta.entities.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario,Long> {

    @Query(value = "SELECT * FROM usuarios WHERE usu_cpf = %:key% OR usu_email = %:key%", nativeQuery = true)
    public Usuario findByKeyAccess(@Param("key") String key);
}
