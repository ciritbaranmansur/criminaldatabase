import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ApiService } from '../../services/api.service';
import { Suspect, Crime } from '../../models/models';

@Component({
  selector: 'app-suspect-detail',
  templateUrl: './suspect-detail.component.html'
})
export class SuspectDetailComponent implements OnInit {
  suspect: Suspect | null = null;
  crimes: Crime[] = [];
  loading = true;
  error = '';

  constructor(private route: ActivatedRoute, private api: ApiService, private router: Router) {}

  ngOnInit(): void {
    const id = Number(this.route.snapshot.paramMap.get('id'));
    this.api.getSuspectById(id).subscribe({
      next: s => {
        this.suspect = s;
        this.api.getCrimesBySuspect(id).subscribe({
          next: c => { this.crimes = c; this.loading = false; },
          error: () => { this.loading = false; }
        });
      },
      error: () => { this.error = 'Suspect not found.'; this.loading = false; }
    });
  }

  getGenderLabel(g: string): string {
    return g === 'M' ? 'Male' : 'Female';
  }

  getStatusClass(status: string): string {
    const m: Record<string, string> = {
      'Active': 'bg-info',
      'Released': 'bg-secondary',
      'Wanted': 'bg-danger',
      'Incarcerated': 'bg-purple'
    };
    return m[status] || 'bg-secondary';
  }

  getCrimeStatusClass(status: string): string {
    const m: Record<string, string> = {
      'Closed': 'bg-success',
      'Under Investigation': 'bg-warning text-dark',
      'Open': 'bg-danger'
    };
    return m[status] || 'bg-secondary';
  }

  goBack(): void {
    this.router.navigate(['/suspects']);
  }
}
