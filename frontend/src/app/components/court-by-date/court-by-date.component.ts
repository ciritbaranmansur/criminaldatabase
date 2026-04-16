import { Component } from '@angular/core';
import { ApiService } from '../../services/api.service';
import { CourtHearingDTO } from '../../models/models';

@Component({
  selector: 'app-court-by-date',
  templateUrl: './court-by-date.component.html'
})
export class CourtByDateComponent {
  selectedDate = '';
  results: CourtHearingDTO[] = [];
  loading = false;
  searched = false;
  error = '';

  constructor(private api: ApiService) {}

  search(): void {
    if (!this.selectedDate) return;
    this.loading = true;
    this.searched = false;
    this.error = '';

    this.api.getCourtByDate(this.selectedDate).subscribe({
      next: data => {
        this.results = data;
        this.loading = false;
        this.searched = true;
      },
      error: () => {
        this.error = 'Failed to retrieve court hearings.';
        this.loading = false;
      }
    });
  }

  getVerdictClass(verdict: string | null): string {
    if (!verdict) return 'badge bg-secondary';
    const m: Record<string, string> = {
      'Guilty': 'badge bg-danger',
      'Not Guilty': 'badge bg-success',
      'Pending': 'badge bg-warning text-dark'
    };
    return m[verdict] || 'badge bg-secondary';
  }
}
