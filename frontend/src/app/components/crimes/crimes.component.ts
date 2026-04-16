import { Component, OnInit } from '@angular/core';
import { ApiService } from '../../services/api.service';
import { Crime } from '../../models/models';

@Component({
  selector: 'app-crimes',
  templateUrl: './crimes.component.html'
})
export class CrimesComponent implements OnInit {
  crimes: Crime[] = [];
  loading = true;
  error = '';

  filterType = '';
  filterStatus = '';
  filterCity = '';

  crimeTypes = ['Robbery', 'Fraud', 'Drug Offense', 'Assault', 'Cybercrime', 'Murder', 'Shoplifting'];
  crimeStatuses = ['Closed', 'Under Investigation', 'Open'];

  constructor(private api: ApiService) {}

  ngOnInit(): void {
    this.loadCrimes();
  }

  loadCrimes(): void {
    this.loading = true;
    this.api.getCrimes(this.filterType || undefined, this.filterStatus || undefined, this.filterCity || undefined).subscribe({
      next: data => { this.crimes = data; this.loading = false; },
      error: () => { this.error = 'Failed to load crimes.'; this.loading = false; }
    });
  }

  applyFilters(): void {
    this.loadCrimes();
  }

  clearFilters(): void {
    this.filterType = '';
    this.filterStatus = '';
    this.filterCity = '';
    this.loadCrimes();
  }

  getStatusClass(status: string): string {
    const m: Record<string, string> = {
      'Closed': 'bg-success',
      'Under Investigation': 'bg-warning text-dark',
      'Open': 'bg-danger'
    };
    return m[status] || 'bg-secondary';
  }
}
