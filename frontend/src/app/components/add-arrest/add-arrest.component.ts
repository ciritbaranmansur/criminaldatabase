import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { Suspect, Crime, Officer } from '../../models/models';

@Component({
  selector: 'app-add-arrest',
  templateUrl: './add-arrest.component.html'
})
export class AddArrestComponent implements OnInit {
  form: FormGroup;
  successMsg = '';
  errorMsg = '';
  loading = false;

  suspects: Suspect[] = [];
  crimes: Crime[] = [];
  officers: Officer[] = [];

  constructor(private fb: FormBuilder, private api: ApiService) {
    this.form = this.fb.group({
      crimeId: ['', Validators.required],
      suspectId: ['', Validators.required],
      arrestingOfficerId: ['', Validators.required],
      arrestDate: ['', Validators.required],
      arrestLocation: ['', Validators.required]
    });
  }

  ngOnInit(): void {
    this.api.getSuspects().subscribe(d => this.suspects = d);
    this.api.getCrimes().subscribe(d => this.crimes = d);
    this.api.getOfficers().subscribe(d => this.officers = d);
  }

  submit(): void {
    if (this.form.invalid) return;
    this.loading = true;
    this.successMsg = '';
    this.errorMsg = '';

    const req = {
      crimeId: +this.form.value.crimeId,
      suspectId: +this.form.value.suspectId,
      arrestingOfficerId: +this.form.value.arrestingOfficerId,
      arrestDate: this.form.value.arrestDate,
      arrestLocation: this.form.value.arrestLocation
    };

    this.api.addArrest(req).subscribe({
      next: arrest => {
        this.successMsg = `Arrest #${arrest.arrestId} created successfully!`;
        this.loading = false;
        this.form.reset();
      },
      error: err => {
        this.errorMsg = err.error?.message || 'Failed to create arrest. Check your inputs.';
        this.loading = false;
      }
    });
  }
}
