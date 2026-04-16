import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';
import {
  Suspect, Officer, Crime, Arrest,
  CourtHearingDTO, OfficerArrestStatsDTO,
  AddArrestRequest, AddSuspectRequest, AddCrimeRequest, DashboardStats
} from '../models/models';

@Injectable({ providedIn: 'root' })
export class ApiService {

  private api = environment.apiUrl;

  constructor(private http: HttpClient) {}

  // ── Dashboard ──────────────────────────────────────────────
  getDashboardStats(): Observable<DashboardStats> {
    return this.http.get<DashboardStats>(`${this.api}/dashboard/stats`);
  }

  // ── Suspects ───────────────────────────────────────────────
  getSuspects(search?: string): Observable<Suspect[]> {
    let params = new HttpParams();
    if (search) params = params.set('search', search);
    return this.http.get<Suspect[]>(`${this.api}/suspects`, { params });
  }

  getSuspectById(id: number): Observable<Suspect> {
    return this.http.get<Suspect>(`${this.api}/suspects/${id}`);
  }

  getSuspectsByCrime(crimeId: number): Observable<Suspect[]> {
    return this.http.get<Suspect[]>(`${this.api}/suspects/by-crime/${crimeId}`);
  }

  addSuspect(request: AddSuspectRequest): Observable<Suspect> {
    return this.http.post<Suspect>(`${this.api}/suspects`, request);
  }

  // ── Crimes ─────────────────────────────────────────────────
  getCrimes(type?: string, status?: string, city?: string): Observable<Crime[]> {
    let params = new HttpParams();
    if (type)   params = params.set('type', type);
    if (status) params = params.set('status', status);
    if (city)   params = params.set('city', city);
    return this.http.get<Crime[]>(`${this.api}/crimes`, { params });
  }

  getCrimeById(id: number): Observable<Crime> {
    return this.http.get<Crime>(`${this.api}/crimes/${id}`);
  }

  getCrimesBySuspect(suspectId: number): Observable<Crime[]> {
    return this.http.get<Crime[]>(`${this.api}/crimes/by-suspect/${suspectId}`);
  }

  addCrime(request: AddCrimeRequest): Observable<Crime> {
    return this.http.post<Crime>(`${this.api}/crimes`, request);
  }

  // ── Officers ───────────────────────────────────────────────
  getOfficers(): Observable<Officer[]> {
    return this.http.get<Officer[]>(`${this.api}/officers`);
  }

  getOfficerById(id: number): Observable<Officer> {
    return this.http.get<Officer>(`${this.api}/officers/${id}`);
  }

  addOfficer(request: any): Observable<Officer> {
    return this.http.post<Officer>(`${this.api}/officers`, request);
  }

  // ── Arrests ────────────────────────────────────────────────
  getArrests(): Observable<Arrest[]> {
    return this.http.get<Arrest[]>(`${this.api}/arrests`);
  }

  // ── Feature 1: Court by date ───────────────────────────────
  getCourtByDate(date: string): Observable<CourtHearingDTO[]> {
    return this.http.get<CourtHearingDTO[]>(`${this.api}/sentences/by-date`, {
      params: new HttpParams().set('date', date)
    });
  }

  // ── Feature 2: Officer arrest stats by gender ──────────────
  getArrestStats(): Observable<OfficerArrestStatsDTO[]> {
    return this.http.get<OfficerArrestStatsDTO[]>(`${this.api}/officers/arrest-stats`);
  }

  // ── Feature 3: Update hearing date ────────────────────────
  updateHearingDate(caseNo: number, hearingDate: string): Observable<any> {
    return this.http.put(`${this.api}/sentences/${caseNo}/hearing-date`, { hearingDate });
  }

  // ── Feature 4: Add arrest ─────────────────────────────────
  addArrest(request: AddArrestRequest): Observable<Arrest> {
    return this.http.post<Arrest>(`${this.api}/arrests`, request);
  }

  // ── Feature 5: Remove suspect from crime ──────────────────
  removeSuspectFromCrime(crimeId: number, suspectId: number): Observable<any> {
    return this.http.delete(`${this.api}/crimes/${crimeId}/suspects/${suspectId}`);
  }
}
