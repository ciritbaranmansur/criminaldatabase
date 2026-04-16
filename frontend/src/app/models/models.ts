// ============================================================
// TypeScript interfaces matching the Spring Boot backend models
// ============================================================

export interface Suspect {
  suspectId: number;
  firstName: string;
  lastName: string;
  dateOfBirth: string;
  gender: string;
  nationId: string;
  heightInCm: number | null;
  weightInKg: number | null;
  eyeColor: string | null;
  hairColor: string | null;
  adress: string | null;
  phone: string | null;
}

export interface Officer {
  officerId: number;
  officerRank: string;
  officerName: string;
  officerUnit: string;
}

export interface Crime {
  crimeId: number;
  crimeType: string;
  crimeDate: string;
  crimeTime: string;
  crimeLocation: string;
  city: string;
  district: string | null;
  crimeDescription: string | null;
  crimeStatus: string;
}

export interface Arrest {
  arrestId: number;
  crimeId: number;
  arrestDate: string;
  arrestLocation: string | null;
}

// DTO for Query 1
export interface CourtHearingDTO {
  courtCaseNo: number;
  hearingDate: string;
  suspectId: number;
  firstName: string;
  lastName: string;
  gender: string;
  crimeId: number;
  crimeType: string;
  crimeDate: string;
  city: string;
  crimeDescription: string | null;
  verdict: string | null;
  sentenceLenght: string | null;
}

// DTO for Query 2
export interface OfficerArrestStatsDTO {
  officerId: number;
  officerName: string;
  rankName: string;
  maleArrests: number;
  femaleArrests: number;
  totalArrests: number;
}

// Request for Query 4
export interface AddArrestRequest {
  crimeId: number;
  officerId: number;
  suspectId: number;
  arrestDate: string;
  arrestLocation: string;
}

// Request for adding a suspect
export interface AddSuspectRequest {
  firstName: string;
  lastName: string;
  dateOfBirth: string;
  gender: string;
  nationId: string;
  heightInCm: number | null;
  weightInKg: number | null;
  eyeColor: string | null;
  hairColor: string | null;
  adress: string | null;
  phone: string | null;
}

// Request for adding a crime
export interface AddCrimeRequest {
  crimeType: string;
  crimeDate: string;
  crimeTime: string;
  crimeLocation: string;
  city: string;
  district: string | null;
  crimeDescription: string | null;
  crimeStatus: string;
}

// Dashboard stats
export interface DashboardStats {
  totalCrimes: number;
  totalSuspects: number;
  totalOfficers: number;
  totalArrests: number;
  crimesByType: { type: string; count: number }[];
  crimesByStatus: { status: string; count: number }[];
}
