package com.example.peralta.repositories;

import com.example.peralta.entities.Feedback;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface FeedbackRepository extends JpaRepository<Feedback, Long>
{
    @Query(value = "SELECT * FROM feedbacks WHERE den_id = :id", nativeQuery = true)
    public Feedback findByReportId(@Param("id") Long id);
}