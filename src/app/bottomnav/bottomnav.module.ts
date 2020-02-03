import { NgModule, NO_ERRORS_SCHEMA } from '@angular/core';

import { BottomnavRoutingModule } from './bottomnav-routing.module';
import { NativeScriptCommonModule } from 'nativescript-angular/common';
import { BottomnavComponent } from './bottomnav.component';
import { NativeScriptRouterModule } from 'nativescript-angular/router';
import { SearchComponent } from "../search/search.component";
import { BrowseComponent } from "../browse/browse.component";

@NgModule({

	declarations: [BottomnavComponent, SearchComponent, BrowseComponent],
	imports: [
		BottomnavRoutingModule,
		NativeScriptCommonModule,
	],
	exports: [NativeScriptRouterModule],
	schemas: [NO_ERRORS_SCHEMA]
})
export class BottomnavModule { }
