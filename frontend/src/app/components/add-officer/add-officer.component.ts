import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { OfficerRank, Unit } from '../../models/models';

@Component({
  selector: 'app-add-officer',
  templateUrl: './add-officer.component.html'
})
export class AddOfficerComponent implements OnInit {
  form: FormGroup;
  loading = false;
  successMsg = '';
  errorMsg = '';
  addedOfficerId: number | null = null;

  ranks: OfficerRank[] = [];
  units: Unit[] = [];

  constructor(private fb: FormBuilder, private api: ApiService) {
    this.form = this.fb.group({
      firstName:   ['', Validators.required],
      lastName:    ['', Validators.required],
      badgeNumber: ['', Validators.required],
      rankId:      ['', Validators.required],
      unitId:      ['', Validators.required],
      phone:       [null],
      email:       [null]
    });
  }

  ngOnInit(): void {
    this.api.getOfficerRanks().subscribe(d => this.ranks = d);
    this.api.getOfficerUnits().subscribe(d => this.units = d);
  }

  submit(): void {
    if (this.form.invalid) return;
    this.loading = true;
    this.successMsg = '';
    this.errorMsg = '';

    this.api.addOfficer(this.form.value).subscribe({
      next: o => {
        this.successMsg = `Officer added successfully with ID #${o.officerId}.`;
        this.addedOfficerId = o.officerId;
        this.loading = false;
        this.form.reset();
      },
      error: err => {
        this.errorMsg = err.error?.message || 'Failed to add officer. Badge number may already exist.';
        this.loading = false;
      }
    });
  }

  reset(): void {
    this.form.reset();
    this.successMsg = '';
    this.errorMsg = '';
    this.addedOfficerId = null;
  }
}
