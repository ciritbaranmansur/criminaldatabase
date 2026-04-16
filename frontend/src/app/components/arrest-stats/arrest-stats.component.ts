import { Component, OnInit } from '@angular/core';
import { ApiService } from '../../services/api.service';
import { OfficerArrestStatsDTO } from '../../models/models';

@Component({
  selector: 'app-arrest-stats',
  templateUrl: './arrest-stats.component.html'
})
export class ArrestStatsComponent implements OnInit {
  stats: OfficerArrestStatsDTO[] = [];
  loading = true;
  error = '';

  constructor(private api: ApiService) {}

  ngOnInit(): void {
    this.api.getArrestStats().subscribe({
      next: data => { this.stats = data; this.loading = false; },
      error: () => { this.error = 'Failed to load arrest statistics.'; this.loading = false; }
    });
  }

  getMalePercent(row: OfficerArrestStatsDTO): number {
    if (!row.totalArrests) return 0;
    return Math.round((row.maleArrests / row.totalArrests) * 100);
  }

  getFemalePercent(row: OfficerArrestStatsDTO): number {
    if (!row.totalArrests) return 0;
    return Math.round((row.femaleArrests / row.totalArrests) * 100);
  }
}
