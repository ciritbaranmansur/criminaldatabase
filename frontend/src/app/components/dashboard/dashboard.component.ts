import { Component, OnInit } from '@angular/core';
import { ApiService } from '../../services/api.service';
import { DashboardStats } from '../../models/models';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html'
})
export class DashboardComponent implements OnInit {
  stats: DashboardStats | null = null;
  loading = true;
  error = '';

  constructor(private api: ApiService) {}

  ngOnInit(): void {
    this.api.getDashboardStats().subscribe({
      next: data => { this.stats = data; this.loading = false; },
      error: () => { this.error = 'Failed to load dashboard stats. Is the backend running?'; this.loading = false; }
    });
  }

  getStatusClass(status: string): string {
    const map: Record<string, string> = {
      'Closed': 'badge bg-success',
      'Open': 'badge bg-danger',
      'Under Investigation': 'badge bg-warning text-dark'
    };
    return map[status] || 'badge bg-secondary';
  }
}
