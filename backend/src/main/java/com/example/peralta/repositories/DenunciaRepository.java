package com.example.peralta.repositories;

import com.example.peralta.entities.Denuncia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DenunciaRepository extends JpaRepository<Denuncia,Long> {

    @Query(value = "SELECT * FROM denuncias WHERE usu_id = :id", nativeQuery = true)
    public List<Denuncia> getByUserId(@Param("id") Long id);
}
