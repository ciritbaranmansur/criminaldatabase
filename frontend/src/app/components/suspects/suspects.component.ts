import { Component, OnInit } from '@angular/core';
import { ApiService } from '../../services/api.service';
import { Suspect } from '../../models/models';

@Component({
  selector: 'app-suspects',
  templateUrl: './suspects.component.html'
})
export class SuspectsComponent implements OnInit {
  suspects: Suspect[] = [];
  loading = true;
  error = '';
  searchQuery = '';

  constructor(private api: ApiService) {}

  ngOnInit(): void {
    this.loadSuspects();
  }

  loadSuspects(): void {
    this.loading = true;
    this.api.getSuspects(this.searchQuery || undefined).subscribe({
      next: data => { this.suspects = data; this.loading = false; },
      error: () => { this.error = 'Failed to load suspects.'; this.loading = false; }
    });
  }

  onSearch(): void {
    this.loadSuspects();
  }

  clearSearch(): void {
    this.searchQuery = '';
    this.loadSuspects();
  }

  getGenderLabel(g: string): string {
    return g === 'M' ? 'Male' : 'Female';
  }
}
