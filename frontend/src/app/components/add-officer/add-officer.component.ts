import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ApiService } from '../../services/api.service';

@Component({
  selector: 'app-add-officer',
  templateUrl: './add-officer.component.html'
})
export class AddOfficerComponent {
  form: FormGroup;
  loading = false;
  successMsg = '';
  errorMsg = '';
  addedOfficerId: number | null = null;

  constructor(private fb: FormBuilder, private api: ApiService) {
    this.form = this.fb.group({
      officerName: ['', Validators.required],
      officerRank: ['', Validators.required],
      officerUnit: ['', Validators.required]
    });
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
        this.errorMsg = err.error?.message || 'Failed to add officer.';
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
