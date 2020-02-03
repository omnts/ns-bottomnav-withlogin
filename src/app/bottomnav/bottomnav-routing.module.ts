import { NgModule } from '@angular/core';
import { Routes } from '@angular/router';
import { NativeScriptRouterModule, NSEmptyOutletComponent } from 'nativescript-angular/router';
import { BottomnavComponent } from './bottomnav.component';
import { SearchComponent } from "../search/search.component";
import { BrowseComponent } from "../browse/browse.component";

const routes: Routes = [
	{
		path: "default",
		component: BottomnavComponent,
		children: [
			{
				path: 'browse',
				component: BrowseComponent,
				outlet: 'browse',
			},
			{
				path: 'search',
				component: SearchComponent,
				outlet: 'search',
			},
		]
	}
];
@NgModule({
	imports: [NativeScriptRouterModule.forChild(routes)],
	exports: [NativeScriptRouterModule]
})
export class BottomnavRoutingModule { }
