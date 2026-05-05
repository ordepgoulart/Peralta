package com.example.peralta.repositories;

import com.example.peralta.entities.Tipo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TipoRepository extends JpaRepository<Tipo,Long> {

    @Query(value = "SELECT * FROM tipo WHERE tip_nome LIKE %:nome%", nativeQuery = true)
    public List<Tipo> findByName(@Param("nome") String nome);
}
