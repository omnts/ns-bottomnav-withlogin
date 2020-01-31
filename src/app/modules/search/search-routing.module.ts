import { NgModule } from '@angular/core';
import { Routes } from '@angular/router';
import { NativeScriptRouterModule } from 'nativescript-angular/router';
import { SearchComponent } from './pages/search.component';
import { NativeScriptCommonModule } from 'nativescript-angular/common';

const searchChildrens: Routes = [
  { path: "", component: SearchComponent },
  //{ path: "", component: SearchComponent, outlet: "search" },
];

@NgModule({
  imports: [
    NativeScriptRouterModule,
    NativeScriptRouterModule.forChild(searchChildrens)
  ],

  exports: [NativeScriptRouterModule]
})

export class SearchRoutingModule { }
