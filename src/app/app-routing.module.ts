import { NgModule } from "@angular/core";
import { Routes } from "@angular/router";
import { NativeScriptRouterModule } from "nativescript-angular/router";

const routes: Routes = [
    { path: "", redirectTo: "/login)", pathMatch: "full" },
    { path: "nav", redirectTo: "/bottomnav/default/(browse:browse//search:search)", pathMatch: "full" },
    { path: "bottomnav", loadChildren: () => import("./bottomnav/bottomnav.module").then(m => m.BottomnavModule) },
    { path: "login", loadChildren: () => import("./login/login.module").then(m => m.LoginModule) }
];

@NgModule({
    imports: [NativeScriptRouterModule.forRoot(routes)],
    exports: [NativeScriptRouterModule]
})
export class AppRoutingModule { }
