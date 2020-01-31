import { NgModule } from '@angular/core';
import { Routes } from '@angular/router';
import { NativeScriptRouterModule, NSEmptyOutletComponent } from 'nativescript-angular/router';
import { BottomnavComponent } from './pages/bottomnav.component';

const routes: Routes = [
  { path: "", redirectTo: "bottomnav", pathMatch: "full" },
  
  { path: "bottomnav", redirectTo: "/(browse:browse//search:search)", pathMatch: "full" },
  //{ path: "browse", outlet: "browse", loadChildren: () => import('../browse/browse.module').then(m => m.BrowseModule)},

  { path: "search", component: NSEmptyOutletComponent, outlet: "search" , loadChildren: () => import('../search/search.module').then(m => m.SearchModule)},
  //{ path: "search", outlet: "search" , loadChildren: () => import('../search/search.module').then(m => m.SearchModule)},

];

@NgModule({
  imports: [NativeScriptRouterModule.forChild([{path: "", component: BottomnavComponent, children: routes}]),],
  exports: [NativeScriptRouterModule]
})
export class BottomnavRoutingModule { }
