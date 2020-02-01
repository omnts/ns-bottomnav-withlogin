import { NgModule } from "@angular/core";
import { NativeScriptRouterModule } from "nativescript-angular/router";
import { Routes } from "@angular/router";
import { LoginComponent } from "./login/login.component";

const routes: Routes = [
    { path: "", redirectTo: "/login", pathMatch: "full" },
    //{ path: "", redirectTo: "/bottomnav", pathMatch: "full" },

    { path: "login", component: LoginComponent},
    //{ path: "login", loadChildren: () => import('./login/login.module').then(m => m.LoginModule)},

    { path: "bottomnav", loadChildren: () => import('./bottomnav/bottomnav.module').then(m => m.BottomnavModule)},
];

@NgModule({
    imports: [NativeScriptRouterModule.forRoot(routes, { enableTracing: true })],
    exports: [NativeScriptRouterModule]
})
export class AppRoutingModule { }
