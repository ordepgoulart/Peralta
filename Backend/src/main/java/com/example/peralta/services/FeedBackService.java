package com.example.peralta.services;

import com.example.peralta.entities.Feedback;
import com.example.peralta.repositories.FeedbackRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FeedBackService {
    @Autowired
    private FeedbackRepository feedbackRepository;

    public List<Feedback> findAll() {
        List<Feedback> feedbacks = feedbackRepository.findAll();
        return feedbacks;
    }

    public Feedback findById(Long id) {
        Feedback feedback = feedbackRepository.findById(id).orElse(null);
        return feedback;
    }

    public Feedback save(Feedback feedback) {
        Feedback newFeedback;
        try {
            newFeedback = feedbackRepository.save(feedback);
        }
        catch (Exception e) {
            newFeedback = null;
        }
        return newFeedback;
    }

    public boolean delete(Long id) {
        if(findById(id) == null) {
            return false;
        }
        else  {
            feedbackRepository.deleteById(id);
            return true;
        }
    }

    public Feedback getByReportId(Long id) {
        Feedback feedback = feedbackRepository.findByReportId(id);
        return feedback;
    }

}
