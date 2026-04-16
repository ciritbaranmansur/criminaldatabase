package com.criminaldb.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDate;

/**
 * Request body for Query 3: Change hearing date for a particular court case.
 */
@Getter @Setter @NoArgsConstructor
public class UpdateHearingDateRequest {
    private LocalDate hearingDate;
}
