import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ApiService } from '../../services/api.service';

@Component({
  selector: 'app-add-suspect',
  templateUrl: './add-suspect.component.html'
})
export class AddSuspectComponent {
  form: FormGroup;
  loading = false;
  successMsg = '';
  errorMsg = '';
  addedSuspectId: number | null = null;

  genderOptions = [
    { value: 'M', label: 'Male' },
    { value: 'F', label: 'Female' }
  ];

  statusOptions = ['Active', 'Wanted', 'Incarcerated', 'Released'];

  eyeColorOptions = ['Brown', 'Blue', 'Green', 'Gray', 'Hazel', 'Black', 'Other'];
  hairColorOptions = ['Black', 'Brown', 'Blonde', 'Red', 'Gray', 'White', 'Bald', 'Other'];

  constructor(private fb: FormBuilder, private api: ApiService) {
    this.form = this.fb.group({
      firstName:   ['', Validators.required],
      lastName:    ['', Validators.required],
      dateOfBirth: ['', Validators.required],
      gender:      ['', Validators.required],
      nationId:    ['', Validators.required],
      heightCm:    [null],
      weightKg:    [null],
      eyeColor:    [null],
      hairColor:   [null],
      address:     [null],
      status:      ['Active', Validators.required]
    });
  }

  submit(): void {
    if (this.form.invalid) return;
    this.loading = true;
    this.successMsg = '';
    this.errorMsg = '';

    this.api.addSuspect(this.form.value).subscribe({
      next: s => {
        this.successMsg = `Suspect added successfully with ID #${s.suspectId}.`;
        this.addedSuspectId = s.suspectId;
        this.loading = false;
        this.form.reset({ status: 'Active', gender: '' });
      },
      error: err => {
        this.errorMsg = err.error?.message || 'Failed to add suspect.';
        this.loading = false;
      }
    });
  }

  reset(): void {
    this.form.reset({ status: 'Active', gender: '' });
    this.successMsg = '';
    this.errorMsg = '';
    this.addedSuspectId = null;
  }
}
