import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NavbarComponent } from './components/navbar/navbar.component';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { SuspectsComponent } from './components/suspects/suspects.component';
import { CrimesComponent } from './components/crimes/crimes.component';
import { OfficersComponent } from './components/officers/officers.component';
import { CourtByDateComponent } from './components/court-by-date/court-by-date.component';
import { ArrestStatsComponent } from './components/arrest-stats/arrest-stats.component';
import { UpdateHearingComponent } from './components/update-hearing/update-hearing.component';
import { AddArrestComponent } from './components/add-arrest/add-arrest.component';
import { RemoveSuspectComponent } from './components/remove-suspect/remove-suspect.component';
import { AddSuspectComponent } from './components/add-suspect/add-suspect.component';
import { AddCrimeComponent } from './components/add-crime/add-crime.component';
import { AddOfficerComponent } from './components/add-officer/add-officer.component';
import { SuspectDetailComponent } from './components/suspect-detail/suspect-detail.component';
import { CrimeDetailComponent } from './components/crime-detail/crime-detail.component';

@NgModule({
  declarations: [
    AppComponent,
    NavbarComponent,
    DashboardComponent,
    SuspectsComponent,
    CrimesComponent,
    OfficersComponent,
    CourtByDateComponent,
    ArrestStatsComponent,
    UpdateHearingComponent,
    AddArrestComponent,
    RemoveSuspectComponent,
    AddSuspectComponent,
    AddCrimeComponent,
    AddOfficerComponent,
    SuspectDetailComponent,
    CrimeDetailComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    ReactiveFormsModule,
    FormsModule
  ],
  bootstrap: [AppComponent]
})
export class AppModule {}
