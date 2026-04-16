package com.criminaldb.service;

import com.criminaldb.dto.CourtHearingDTO;
import com.criminaldb.model.Sentence;
import com.criminaldb.repository.SentenceRepository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class SentenceService {

    private final SentenceRepository sentenceRepository;

    public SentenceService(SentenceRepository sentenceRepository) {
        this.sentenceRepository = sentenceRepository;
    }

    public List<Sentence> getAll() {
        return sentenceRepository.findAll();
    }

    /**
     * Query 1: All suspects and crime info appearing in court on a certain date.
     */
    public List<CourtHearingDTO> getByHearingDate(LocalDate date) {
        return sentenceRepository.findByHearingDate(date)
                .stream()
                .map(CourtHearingDTO::fromRow)
                .collect(Collectors.toList());
    }

    /**
     * Query 3: Change the hearing date for a particular court case.
     */
    @Transactional
    public boolean updateHearingDate(Integer caseNo, LocalDate newDate) {
        int updated = sentenceRepository.updateHearingDate(caseNo, newDate);
        return updated > 0;
    }
}
