package com.smartanswer.ocrproject.repository;

import com.smartanswer.ocrproject.model.Answer;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Date;

@Repository
public interface AnswerRepository extends MongoRepository<Answer,Long> {
    Answer findOneByOwnerAndDate(String owner,String searchDate);
}

