import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { DashboardComponent }     from './components/dashboard/dashboard.component';
import { SuspectsComponent }      from './components/suspects/suspects.component';
import { CrimesComponent }        from './components/crimes/crimes.component';
import { OfficersComponent }      from './components/officers/officers.component';
import { CourtByDateComponent }   from './components/court-by-date/court-by-date.component';
import { ArrestStatsComponent }   from './components/arrest-stats/arrest-stats.component';
import { UpdateHearingComponent } from './components/update-hearing/update-hearing.component';
import { AddArrestComponent }     from './components/add-arrest/add-arrest.component';
import { RemoveSuspectComponent } from './components/remove-suspect/remove-suspect.component';
import { AddSuspectComponent }    from './components/add-suspect/add-suspect.component';
import { AddCrimeComponent }      from './components/add-crime/add-crime.component';
import { AddOfficerComponent }      from './components/add-officer/add-officer.component';
import { SuspectDetailComponent }   from './components/suspect-detail/suspect-detail.component';
import { CrimeDetailComponent }     from './components/crime-detail/crime-detail.component';

const routes: Routes = [
  { path: '',               redirectTo: 'dashboard', pathMatch: 'full' },
  { path: 'dashboard',      component: DashboardComponent },
  { path: 'suspects',       component: SuspectsComponent },
  { path: 'suspects/:id',   component: SuspectDetailComponent },
  { path: 'crimes',         component: CrimesComponent },
  { path: 'crimes/:id',     component: CrimeDetailComponent },
  { path: 'officers',       component: OfficersComponent },
  { path: 'court-by-date',  component: CourtByDateComponent },
  { path: 'arrest-stats',   component: ArrestStatsComponent },
  { path: 'update-hearing', component: UpdateHearingComponent },
  { path: 'add-arrest',     component: AddArrestComponent },
  { path: 'remove-suspect', component: RemoveSuspectComponent },
  { path: 'add-suspect',    component: AddSuspectComponent },
  { path: 'add-crime',      component: AddCrimeComponent },
  { path: 'add-officer',    component: AddOfficerComponent },
  { path: '**',             redirectTo: 'dashboard' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {}
