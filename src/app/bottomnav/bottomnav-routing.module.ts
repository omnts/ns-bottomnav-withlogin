import { NgModule } from '@angular/core';
import { Routes } from '@angular/router';
import { NativeScriptRouterModule, NSEmptyOutletComponent } from 'nativescript-angular/router';
import { BottomnavComponent } from './bottomnav.component';
import { NativeScriptCommonModule } from 'nativescript-angular/common';
import { BrowseComponent } from '../browse/browse.component';
import { SearchModule } from '../search/search.module';
import { SearchComponent } from '../search/search.component';

const routes: Routes = [
  //{ path: "", redirectTo: "bottomnav", pathMatch: "full" },
  //{ path: "bottomnav", redirectTo: "/(browse:browse//search:search)", pathMatch: "full" },
  
  { 
    path: "browse", 
    component: BrowseComponent, 
    outlet: "browse",
    //loadChildren: () => import('../browse/browse.module').then(m => m.BrowseModule)
  },

  { 
    path: "search", 
    component: SearchComponent, 
    outlet: "search" ,
    //loadChildren: () => import('../search/search.module').then(m => m.SearchModule)
  },

];

@NgModule({
  
  declarations: [
    SearchComponent,
    BrowseComponent
  ],
  imports: [
    NativeScriptCommonModule,
    NativeScriptRouterModule,
    NativeScriptRouterModule.forChild([{path: "default", component: BottomnavComponent, children: routes}]),],
    //exports: [NativeScriptRouterModule]
})
export class BottomnavRoutingModule { }
