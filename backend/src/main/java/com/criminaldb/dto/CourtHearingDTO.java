package com.criminaldb.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDate;

/**
 * DTO for Query 1: Suspects and crime info appearing in court on a certain date.
 */
@Getter @Setter @NoArgsConstructor
public class CourtHearingDTO {
    private Integer courtCaseNo;
    private LocalDate hearingDate;
    private Integer suspectId;
    private String firstName;
    private String lastName;
    private String gender;
    private Integer crimeId;
    private String crimeType;
    private LocalDate crimeDate;
    private String city;
    private String description;
    private String verdict;
    private String sentenceType;

    public static CourtHearingDTO fromRow(Object[] row) {
        CourtHearingDTO dto = new CourtHearingDTO();
        dto.courtCaseNo      = row[0] != null ? ((Number) row[0]).intValue() : null;
        dto.hearingDate      = row[1] instanceof java.sql.Date d ? d.toLocalDate() : null;
        dto.suspectId        = row[2] != null ? ((Number) row[2]).intValue() : null;
        dto.firstName        = (String) row[3];
        dto.lastName         = (String) row[4];
        dto.gender           = row[5] != null ? String.valueOf(row[5]) : null;
        dto.crimeId          = row[6] != null ? ((Number) row[6]).intValue() : null;
        dto.crimeType        = (String) row[7];
        dto.crimeDate        = row[8] instanceof java.sql.Date d ? d.toLocalDate() : null;
        dto.city             = (String) row[9];
        dto.description      = (String) row[10];
        dto.verdict          = (String) row[11];
        dto.sentenceType     = (String) row[12];
        return dto;
    }
}
