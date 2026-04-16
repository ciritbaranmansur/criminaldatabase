package com.criminaldb.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * DTO for Query 2: Officers and how many suspects of each gender were arrested by each officer.
 */
@Getter @Setter @NoArgsConstructor
public class OfficerArrestStatsDTO {
    private Integer officerId;
    private String officerName;
    private String rankName;
    private Long maleArrests;
    private Long femaleArrests;
    private Long totalArrests;

    public static OfficerArrestStatsDTO fromRow(Object[] row) {
        OfficerArrestStatsDTO dto = new OfficerArrestStatsDTO();
        dto.officerId    = row[0] != null ? ((Number) row[0]).intValue() : null;
        dto.officerName  = (String) row[1];
        dto.rankName     = (String) row[2];
        dto.maleArrests  = row[3] != null ? ((Number) row[3]).longValue() : 0L;
        dto.femaleArrests= row[4] != null ? ((Number) row[4]).longValue() : 0L;
        dto.totalArrests = row[5] != null ? ((Number) row[5]).longValue() : 0L;
        return dto;
    }
}
