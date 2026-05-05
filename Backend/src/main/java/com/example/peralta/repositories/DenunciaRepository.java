package com.example.peralta.repositories;

import com.example.peralta.entities.Denuncia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DenunciaRepository extends JpaRepository<Denuncia,Long> {
}
