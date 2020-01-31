import { NgModule, NO_ERRORS_SCHEMA } from '@angular/core';

import { BottomnavRoutingModule } from './bottomnav-routing.module';
import { NativeScriptCommonModule } from 'nativescript-angular/common';
import { BottomnavComponent } from './pages/bottomnav.component';
import { NativeScriptRouterModule } from 'nativescript-angular/router';


@NgModule({
  
  declarations: [BottomnavComponent],
  imports: [
    BottomnavRoutingModule,
    NativeScriptCommonModule,
  ],
  exports: [NativeScriptRouterModule],
  schemas: [NO_ERRORS_SCHEMA]
})
export class BottomnavModule { }
