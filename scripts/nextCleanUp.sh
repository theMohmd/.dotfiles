rm public/*

mkdir src/components
mkdir src/hooks
mkdir src/utils

echo "const Home = () => {
    return <div>Home</div>;
};

export default Home;
" > src/app/page.tsx

echo "@tailwind base;
@tailwind components;
@tailwind utilities;
" > src/app/globals.css
