#!/bin/bash

Shellout (){
    [ "$1" = "" ] || echo "ERROR : $1"
    exit 1
}

Usage (){
    echo
    echo "Usage :"
    echo "  `basename \"$0\"` -i <module name> -p <page name>"
    echo "  `basename \"$0\"` -i 'cart' -p 'delivery'"
    echo
    echo "ERROR $1"
    echo
    exit 1
}

DATE=`date +%Y%m%d%H%M%S`

while getopts "h:i:p:" arg; do
    case $arg in
        h)
            Usage ;
            ;;
        i)
            MODULE_NAME=$OPTARG
            ;;
        p)
            PAGE_NAME=$OPTARG
            ;;
        *)
            Usage "Illegal option $OPTARG"
            ;;
    esac
done

DIR_SCRIPT=`dirname "$0"`

UPPER_MODULE_NAME_TEMP="$(tr '[:lower:]' '[:upper:]' <<< ${MODULE_NAME:0:1})${MODULE_NAME:1}"
UPPER_MODULE_NAME=`perl "${DIR_SCRIPT}/camlize.pl" camelize "$UPPER_MODULE_NAME_TEMP" | sed -e "s/-//g"`
echo "UPPER_MODULE_NAME_TEMP=$UPPER_MODULE_NAME_TEMP"
echo "UPPER_MODULE_NAME=$UPPER_MODULE_NAME"


cd "$DIR_SCRIPT" || echo "-- Error while trying to cd $DIR_SCRIPT"
cd ..
[ -d ".git" ] || Shellout "You must be in the root project dir."
ROOT_DIR=`pwd`
cd "$ROOT_DIR" || echo "-- Error while trying to cd $ROOT_DIR"

[ "$MODULE_NAME" == "" ] && Usage "Module name is mandatory"

if [ "$MODULE_NAME" != "" ] && [ ! -f "${ROOT_DIR}/src/app/modules/${MODULE_NAME}/${MODULE_NAME}.module.ts" ]
then
    [ -d "src/app" ] || shellout "Dir src/app not found in $ROOT_DIR"
    
    mkdir "${ROOT_DIR}/src/app/global_services" "${ROOT_DIR}/src/app/modules" "${ROOT_DIR}/src/app/components" 2> /dev/null

    cd "${ROOT_DIR}/src/app/modules" || echo "-- Error while trying to cd ${ROOT_DIR}/src/app/modules"
    echo "mkdir $MODULE_NAME"
    mkdir "$MODULE_NAME"

    cd "$MODULE_NAME" || echo "-- Error while trying to cd $MODULE_NAME"
    echo "mkdir shared pages components"
    mkdir "shared" "pages" "components"
    cd ..

    echo "### ng generate module ${MODULE_NAME}"
    ng generate module --routing ${MODULE_NAME}

    cd $MODULE_NAME/pages || echo "-- Error while trying to cd $pages"
    echo "### ng generate component ${MODULE_NAME} --flat"
    ng generate component ${MODULE_NAME} --flat
fi

if [ "$MODULE_NAME" != "" ] && [ "$PAGE_NAME" != "" ]
then
    cd "${ROOT_DIR}/src/app/modules/$MODULE_NAME/pages/" || echo "-- Error while trying to cd src/app/modules/$MODULE_NAME/pages/"
    ng generate component ${PAGE_NAME}
fi

echo
echo "Dont forget to update the bellow files :"
echo
cat << EOF
//app-routing.module.ts
const routes: Routes = [
    //{ path: "", redirectTo: "/login", pathMatch: "full" },
    { path: "login", component: LoginComponent },
    { path: "${MODULE_NAME}", loadChildren: './modules/${MODULE_NAME}/${MODULE_NAME}.module#${UPPER_MODULE_NAME}Module' },    
    { path: "", loadChildren: './modules/${MODULE_NAME}/${MODULE_NAME}.module#${UPPER_MODULE_NAME}Module' },    
];

//${MODULE_NAME}-routing.module.ts
import { ${UPPER_MODULE_NAME}Component } from './pages/${MODULE_NAME}.component';

const routes: Routes = [
  { path: "", component: ${UPPER_MODULE_NAME}Component, pathMatch: "full" }
];
EOF
