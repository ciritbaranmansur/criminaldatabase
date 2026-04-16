import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ApiService } from '../../services/api.service';

@Component({
  selector: 'app-update-hearing',
  templateUrl: './update-hearing.component.html'
})
export class UpdateHearingComponent {
  form: FormGroup;
  successMsg = '';
  errorMsg = '';
  loading = false;

  constructor(private fb: FormBuilder, private api: ApiService) {
    this.form = this.fb.group({
      caseNo: ['', [Validators.required, Validators.min(1)]],
      hearingDate: ['', Validators.required]
    });
  }

  submit(): void {
    if (this.form.invalid) return;
    this.loading = true;
    this.successMsg = '';
    this.errorMsg = '';

    const { caseNo, hearingDate } = this.form.value;

    this.api.updateHearingDate(+caseNo, hearingDate).subscribe({
      next: res => {
        this.successMsg = res.message || 'Hearing date updated successfully.';
        this.loading = false;
        this.form.reset();
      },
      error: err => {
        this.errorMsg = err.error?.message || 'Failed to update hearing date. Check the case number.';
        this.loading = false;
      }
    });
  }
}
