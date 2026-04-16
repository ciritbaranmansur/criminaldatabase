import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { Crime, Officer, Suspect } from '../../models/models';

@Component({
  selector: 'app-add-arrest',
  templateUrl: './add-arrest.component.html'
})
export class AddArrestComponent implements OnInit {
  form: FormGroup;
  successMsg = '';
  errorMsg = '';
  loading = false;

  crimes: Crime[] = [];
  officers: Officer[] = [];
  suspects: Suspect[] = [];

  constructor(private fb: FormBuilder, private api: ApiService) {
    this.form = this.fb.group({
      crimeId:        ['', Validators.required],
      officerId:      ['', Validators.required],
      suspectId:      ['', Validators.required],
      arrestDate:     ['', Validators.required],
      arrestLocation: ['', Validators.required]
    });
  }

  ngOnInit(): void {
    this.api.getCrimes().subscribe(d => this.crimes = d);
    this.api.getOfficers().subscribe(d => this.officers = d);
    this.api.getSuspects().subscribe(d => this.suspects = d);
  }

  submit(): void {
    if (this.form.invalid) return;
    this.loading = true;
    this.successMsg = '';
    this.errorMsg = '';

    const req = {
      crimeId:        +this.form.value.crimeId,
      officerId:      +this.form.value.officerId,
      suspectId:      +this.form.value.suspectId,
      arrestDate:     this.form.value.arrestDate,
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
