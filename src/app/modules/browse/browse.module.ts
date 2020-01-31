import { NgModule, NO_ERRORS_SCHEMA } from '@angular/core';

import { NativeScriptCommonModule } from 'nativescript-angular/common';
import { BrowseComponent } from './pages/browse.component';
import { BrowseRoutingModule } from './browse-routing.module';

@NgModule({
  declarations: [
    BrowseComponent
  ],
  imports: [
    NativeScriptCommonModule,
    BrowseRoutingModule
  ],
  schemas: [
    NO_ERRORS_SCHEMA
  ]
})
export class BrowseModule { }
