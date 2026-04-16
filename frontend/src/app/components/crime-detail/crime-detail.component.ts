import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ApiService } from '../../services/api.service';
import { Crime, Suspect } from '../../models/models';

@Component({
  selector: 'app-crime-detail',
  templateUrl: './crime-detail.component.html'
})
export class CrimeDetailComponent implements OnInit {
  crime: Crime | null = null;
  suspects: Suspect[] = [];
  loading = true;
  error = '';

  constructor(private route: ActivatedRoute, private api: ApiService, private router: Router) {}

  ngOnInit(): void {
    const id = Number(this.route.snapshot.paramMap.get('id'));
    this.api.getCrimeById(id).subscribe({
      next: c => {
        this.crime = c;
        this.api.getSuspectsByCrime(id).subscribe({
          next: s => { this.suspects = s; this.loading = false; },
          error: () => { this.loading = false; }
        });
      },
      error: () => { this.error = 'Crime not found.'; this.loading = false; }
    });
  }

  getStatusClass(status: string): string {
    const m: Record<string, string> = {
      'Closed': 'bg-success',
      'Under Investigation': 'bg-warning text-dark',
      'Open': 'bg-danger'
    };
    return m[status] || 'bg-secondary';
  }

  getGenderLabel(g: string): string {
    return g === 'M' ? 'Male' : 'Female';
  }

  goBack(): void {
    this.router.navigate(['/crimes']);
  }
}
