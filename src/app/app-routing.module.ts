import { NgModule } from "@angular/core";
import { NativeScriptRouterModule } from "nativescript-angular/router";
import { Routes } from "@angular/router";

const routes: Routes = [
    { path: "", redirectTo: "/login", pathMatch: "full" },
    //{ path: "", redirectTo: "/bottomnav", pathMatch: "full" },
    
    { path: "login", loadChildren: () => import('./login/login.module').then(m => m.LoginModule)},
    { path: "bottomnav", loadChildren: () => import('./bottomnav/bottomnav.module').then(m => m.BottomnavModule)},
];

@NgModule({
    declarations: [],

    imports: [
        NativeScriptRouterModule.forRoot(routes, { enableTracing: true })
    ],
    exports: [NativeScriptRouterModule]
})
export class AppRoutingModule { }
