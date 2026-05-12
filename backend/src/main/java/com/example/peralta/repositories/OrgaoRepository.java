package com.example.peralta.repositories;

import com.example.peralta.entities.Orgao;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrgaoRepository extends JpaRepository<Orgao,Long> {

    @Query(value = "SELECT * FROM orgaos WHERE org_nome LIKE %:nome%;", nativeQuery = true)
    public List<Orgao> findByNome(@Param("nome") String nome);
}
