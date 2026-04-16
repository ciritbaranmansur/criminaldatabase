import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ApiService } from '../../services/api.service';

@Component({
  selector: 'app-add-crime',
  templateUrl: './add-crime.component.html'
})
export class AddCrimeComponent {
  form: FormGroup;
  loading = false;
  successMsg = '';
  errorMsg = '';
  addedCrimeId: number | null = null;

  crimeTypes = [
    'Homicide', 'Assault', 'Robbery', 'Burglary', 'Theft',
    'Fraud', 'Drug Trafficking', 'Cybercrime', 'Kidnapping',
    'Vandalism', 'Money Laundering', 'Arson', 'Sexual Assault', 'Other'
  ];

  statusOptions = ['Open', 'Under Investigation', 'Closed', 'Cold Case'];

  constructor(private fb: FormBuilder, private api: ApiService) {
    this.form = this.fb.group({
      crimeType:        ['', Validators.required],
      crimeDate:        ['', Validators.required],
      crimeTime:        ['00:00', Validators.required],
      crimeLocation:    ['', Validators.required],
      city:             ['', Validators.required],
      district:         [null],
      crimeDescription: [null],
      crimeStatus:      ['Under Investigation', Validators.required]
    });
  }

  submit(): void {
    if (this.form.invalid) return;
    this.loading = true;
    this.successMsg = '';
    this.errorMsg = '';

    this.api.addCrime(this.form.value).subscribe({
      next: c => {
        this.successMsg = `Crime added successfully with ID #${c.crimeId}.`;
        this.addedCrimeId = c.crimeId;
        this.loading = false;
        this.form.reset({ crimeStatus: 'Under Investigation', crimeTime: '00:00' });
      },
      error: err => {
        this.errorMsg = err.error?.message || 'Failed to add crime.';
        this.loading = false;
      }
    });
  }

  reset(): void {
    this.form.reset({ crimeStatus: 'Under Investigation', crimeTime: '00:00' });
    this.successMsg = '';
    this.errorMsg = '';
    this.addedCrimeId = null;
  }
}
