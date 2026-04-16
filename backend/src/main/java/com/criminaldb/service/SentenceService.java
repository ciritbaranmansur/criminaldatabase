package com.criminaldb.service;

import com.criminaldb.dto.CourtHearingDTO;
import com.criminaldb.model.CourtInformation;
import com.criminaldb.repository.CourtInformationRepository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class SentenceService {

    private final CourtInformationRepository courtInformationRepository;

    public SentenceService(CourtInformationRepository courtInformationRepository) {
        this.courtInformationRepository = courtInformationRepository;
    }

    public List<CourtInformation> getAll() {
        return courtInformationRepository.findAll();
    }

    /**
     * Query 1: All suspects and crime info appearing in court on a certain date.
     */
    public List<CourtHearingDTO> getByHearingDate(LocalDate date) {
        return courtInformationRepository.findByHearingDate(date.toString())
                .stream()
                .map(CourtHearingDTO::fromRow)
                .collect(Collectors.toList());
    }

    /**
     * Query 3: Change the hearing date for a particular court case.
     */
    @Transactional
    public boolean updateHearingDate(Integer caseNo, LocalDate newDate) {
        int updated = courtInformationRepository.updateHearingDate(caseNo, newDate);
        return updated > 0;
    }
}
