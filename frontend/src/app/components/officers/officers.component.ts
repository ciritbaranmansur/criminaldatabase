import { Component, OnInit } from '@angular/core';
import { ApiService } from '../../services/api.service';
import { Officer } from '../../models/models';

@Component({
  selector: 'app-officers',
  templateUrl: './officers.component.html'
})
export class OfficersComponent implements OnInit {
  officers: Officer[] = [];
  loading = true;
  error = '';

  constructor(private api: ApiService) {}

  ngOnInit(): void {
    this.api.getOfficers().subscribe({
      next: data => { this.officers = data; this.loading = false; },
      error: () => { this.error = 'Failed to load officers.'; this.loading = false; }
    });
  }
}
