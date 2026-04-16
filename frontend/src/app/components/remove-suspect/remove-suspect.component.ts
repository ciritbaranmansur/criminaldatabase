import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { Crime, Suspect } from '../../models/models';

@Component({
  selector: 'app-remove-suspect',
  templateUrl: './remove-suspect.component.html'
})
export class RemoveSuspectComponent implements OnInit {
  form: FormGroup;
  successMsg = '';
  errorMsg = '';
  loading = false;
  confirmed = false;

  suspects: Suspect[] = [];
  crimes: Crime[] = [];
  loadingCrimes = false;

  constructor(private fb: FormBuilder, private api: ApiService) {
    this.form = this.fb.group({
      suspectId: ['', Validators.required],
      crimeId:   ['', Validators.required]
    });
  }

  ngOnInit(): void {
    this.api.getSuspects().subscribe(d => this.suspects = d);
  }

  onSuspectChange(): void {
    const suspectId = +this.form.value.suspectId;
    this.form.patchValue({ crimeId: '' });
    this.crimes = [];
    this.confirmed = false;
    if (!suspectId) return;

    this.loadingCrimes = true;
    this.api.getCrimesBySuspect(suspectId).subscribe({
      next: d => { this.crimes = d; this.loadingCrimes = false; },
      error: () => { this.loadingCrimes = false; }
    });
  }

  submit(): void {
    if (this.form.invalid || !this.confirmed) return;
    this.loading = true;
    this.successMsg = '';
    this.errorMsg = '';

    const { crimeId, suspectId } = this.form.value;

    this.api.removeSuspectFromCrime(+crimeId, +suspectId).subscribe({
      next: res => {
        this.successMsg = res.message || 'Suspect removed from crime successfully.';
        this.loading = false;
        this.form.reset();
        this.crimes = [];
        this.confirmed = false;
      },
      error: err => {
        this.errorMsg = err.error?.message || 'Could not remove suspect. Link may not exist.';
        this.loading = false;
      }
    });
  }

  get selectedCrimeName(): string {
    const id = +this.form.value.crimeId;
    const c = this.crimes.find(x => x.crimeId === id);
    return c ? `#${c.crimeId} — ${c.crimeType} (${c.city})` : '';
  }

  get selectedSuspectName(): string {
    const id = +this.form.value.suspectId;
    const s = this.suspects.find(x => x.suspectId === id);
    return s ? `#${s.suspectId} — ${s.firstName} ${s.lastName}` : '';
  }
}
