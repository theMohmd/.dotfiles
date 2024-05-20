#!/bin/bash

Y='\033[0;33m'
EC='\033[0m'

echo -e "(${Y}t${EC}/j)sx: " 
read variant
if [ ! "$variant" = "j"  ]; then
    variant="t"
fi

echo -e "bun? (${Y}y${EC}/n): " 
read bun

if [ ! $bun = "n" ] && [ ! $bun = "N" ]; then
    packageInstaller="npm"
else
    packageInstaller="bun"
fi

echo -e "create vite? (${Y}y${EC}/n): " 
read response

if [ ! "$response" = "n" ] && [ ! "$response" = "N" ]; then
    path="."
    if [ "$1" ]; then
        path=$1
    fi
    var="react"
    if [ ! "$variant" = "j"  ]; then
        var="react-ts"
    fi

    if [ ! $bun = "n" ] && [ ! $bun = "N" ]; then
        $packageInstaller create vite@latest $path -- --template $var
    else
        $packageInstaller create vite@latest $path --template $var
    fi
fi

cd $path

rm src/assets/react.svg
rm src/App.css

mkdir src/api
mkdir src/components
mkdir src/components/ui
mkdir src/components/Common
mkdir src/components/Layout
mkdir src/contexts
mkdir src/hooks
mkdir src/utils
touch src/contexts/Providers.${variant}sx
if [ "$variant" = "t" ]; then
    mkdir src/types
    echo '{
    "compilerOptions": {
        "target": "ES2020",
        "useDefineForClassFields": true,
        "lib": ["ES2020", "DOM", "DOM.Iterable"],
        "module": "ESNext",
        "skipLibCheck": true,
        "baseUrl": ".",
        "paths": {
            "src/*": ["./src/*"],
            "api/*": ["./src/api/*"],
            "components/*": ["./src/components/*"],
            "contexts/*": ["./src/contexts/*"]
            "hooks/*": ["./src/hooks/*"],
            "types/*": ["./src/types/*"],
            "utils/*": ["./src/utils/*"],
        },

        /* Bundler mode */
        "moduleResolution": "bundler",
        "allowImportingTsExtensions": true,
        "resolveJsonModule": true,
        "isolatedModules": true,
        "noEmit": true,
        "jsx": "react-jsx",

        /* Linting */
        "strict": true,
        "noUnusedLocals": true,
        "noUnusedParameters": true,
        "noFallthroughCasesInSwitch": true
    },
    "include": ["src"],
    "references": [{ "path": "./tsconfig.node.json" }]
}' > tsconfig.json
fi

echo "const App = () => {
return (
<div>App</div>
)
}
export default App" 
> src/App.${variant}sx

echo 'import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
    plugins: [react()],
    resolve: {
        alias: {
            src: "/src",
            api: "/src/api",
            components: "/src/components",
            contexts: "/src/contexts",
            hooks: "/src/hooks",
            types: "/src/types",
            utils: "/src/utils",
        },
    },
});' > vite.config.${variant}s

echo -e "tailwind? (${Y}y${EC}/n): " 
read response

if [ ! "$response" = "n" ] || [ "$response" = "N" ]; then

    $packageInstaller install -D tailwindcss postcss autoprefixer

    var="bunx"
    if [ ! $bun = "n" ] && [ ! $bun = "N" ]; then
        var="npx"
    fi
    var2=""
    if [ "$variant" = "t"  ]; then
        var2="--ts"
    fi
    $var tailwindcss init -p var2


    echo "@tailwind base;
@tailwind components;
@tailwind utilities;" > src/index.css

    if [ "$variant" = "t"  ]; then
    echo 'import type { Config } from "tailwindcss";
export default {
    content: [
        "./index.html",
        "./src/**/*.{js,ts,jsx,tsx}",
    ],
    darkMode: "selector",
    theme: {
        extend: {},
    },
    plugins: [],
} satisfies Config;'> tailwind.config.ts
    else
    echo 'export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}'> tailwind.config.js
    fi

fi

echo -e "router? (${Y}y${EC}/n): " 
read response
var="{children}"
if [ ! "$response" = "n" ] || [ "$response" = "N" ]; then
    $packageInstaller i react-router-dom
    var="<BrowserRouter>{children}</BrowserRouter>"
fi

var2="const Providers = ({ children }) => {"
if [ "$variant" = "t" ]; then
    var2=" type ProvidersProps = {
    children: ReactNode;
};
const Providers = ({ children }: ProvidersProps) => {"
fi
echo "import { ReactNode } from 'react';

//Providers component for setting all the Providers for project in one seperate file
$var2
return <>${var}</>;
};

export default Providers;"
> src/contexts/Providers.${variant}sx

git init
git add .
git commit -m "initial commit"
