import { NgModule } from '@angular/core';
import { Routes } from '@angular/router';
import { NativeScriptRouterModule } from 'nativescript-angular/router';
import { LoginComponent } from './pages/login.component';

const routes: Routes = [
  { path: "", component: LoginComponent, pathMatch: "full" }
];

@NgModule({
  imports: [NativeScriptRouterModule.forChild(routes)],
  exports: [NativeScriptRouterModule]
})
export class LoginRoutingModule { }
