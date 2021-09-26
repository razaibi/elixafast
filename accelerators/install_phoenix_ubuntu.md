- Set the name of your app.
```
APP_NAME="<your_app_name>"
```

- Set the database password.
**CAUTION : Do not set passwords in clear text for non-experimental environments.**
```
DB_PASS="<db_password>"
```

- Update packages

```
sudo apt-get update
```

- Setup installation for asdf

```
apt-get -y install build-essential autoconf m4 libncurses5-dev libwxgtk3.0-gtk3-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev openjdk-11-jdk
```

- Ensure git and curl are installed for asdf.

- Download asdf.

```
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
```

- Add the to bashrc

```
echo ". $HOME/.asdf/asdf.sh" >> ~/.bashrc
echo ". $HOME/.asdf/completions/asdf.bash" >> ~/.bashrc
source ~/.bashrc
```

- Add erlang plugin for asdf.

```
asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
```

- Download from Erlang Repo

```
wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb
```

- Install Build Essentials

```
sudo apt-get install -y build-essential
```

- Install Nodejs
```
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
```

- Install Erlang/OTP platform

```
sudo apt-get -y install esl-erlang
```

- Install Elixir

```
sudo apt-get -y install elixir
```

- Install Hex

```
sudo mix local.hex --force
```

- Install iNotify Tools

```
sudo apt-get -y install inotify-tools
```

- Install Phoenix

```
mix archive.install hex phx_new 1.5.10
```

- Install Docker

```
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
sudo service docker start
sudo groupadd docker
sudo usermod -aG docker $USER
```

-- Setup Postgres data folder
```
mkdir ${HOME}/${APP_NAME}-data/
```

- Setup Postgresql (local)
```
## CAUTION: Password in clear text.
docker run -d \
 --name ${APP_NAME}-psql \
 -e POSTGRES_PASSWORD=${DB_PASS} \
 -v ${HOME}/${APP_NAME}-data/:/var/lib/postgresql/data \
 -p 5432:5432 \
 postgres
```

- Setup Live View App

```
mix phx.new --live ${APP_NAME} --install
```

- Setup Tailwind
```
cd ${APP_NAME}
cd assets
sudo npm install tailwindcss postcss autoprefixer postcss-loader@4.2 --save-dev
sudo npm install tailwindcss postcss autoprefixer postcss-loader@4.2 --save-prod
```

- Setup PostCSS config.
```
echo "module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  }
}" >> postcss.config.js
```

- Tie PostCSS Loader to WebPack
```
# Temporary method
line=42
substitute="            'postcss-loader','sass-loader',"
sed -i "${line}s/.*/$substitute/"  webpack.config.js
```

- Install Tailwind CSS in the assets directory
```
npx tailwindcss init
```

- In the assets directory, create the tailwind.config.js. 
  ```
  echo "module.exports = {
    theme: {
      fontFamily: {
        sans: [
          // \"system-ui\",
          \"-apple-system\",
          // \"BlinkMacSystemFont\",
          \"Segoe UI\",
          \"Roboto\",
          \"Helvetica Neue\",
          \"Arial\",
          \"Noto Sans\",
          \"sans-serif\",
          \"Apple Color Emoji\",
          \"Segoe UI Emoji\",
          \"Segoe UI Symbol\",
          \"Noto Color Emoji\",
        ],
      },
      fontSize: {
        xs: '0.75rem',
        sm: '0.875rem',
        base: '1rem',
        lg: '1.125rem',
        xl: '1.25rem',
        '2xl': '1.5rem',
        '3xl': '1.875rem',
        '4xl': '2.25rem',
        '5xl': '3rem',
        '6xl': '4rem',
      },
      colors: {
        transparent: 'transparent',
        white: '#ffffff',
        black: '#000000',
        gray: {
          '50': '#f9fafb',
          '100': '#f4f5f7',
          '200': '#e5e7eb',
          // '200': '#ebecf0',
          '300': '#d2d6dc',
          '400': '#9fa6b2',
          '500': '#6b7280',
          '600': '#4b5563',
          '700': '#374151',
          '800': '#252f3f',
          '900': '#161e2e',
        },
        'cool-gray': {
          '50': '#f8fafc',
          '100': '#f1f5f9',
          '200': '#e2e8f0',
          '300': '#cfd8e3',
          '400': '#97a6ba',
          '500': '#64748b',
          '600': '#475569',
          '700': '#364152',
          '800': '#27303f',
          '900': '#1a202e',
        },
        red: {
          '50': '#fdf2f2',
          '100': '#fde8e8',
          '200': '#fbd5d5',
          '300': '#f8b4b4',
          '400': '#f98080',
          '500': '#f05252',
          '600': '#e02424',
          '700': '#c81e1e',
          '800': '#9b1c1c',
          '900': '#771d1d',
        },
        orange: {
          '50': '#fff8f1',
          '100': '#feecdc',
          '200': '#fcd9bd',
          '300': '#fdba8c',
          '400': '#ff8a4c',
          '500': '#ff5a1f',
          '600': '#d03801',
          '700': '#b43403',
          '800': '#8a2c0d',
          '900': '#73230d',
        },
        yellow: {
          '50': '#fdfdea',
          '100': '#fdf6b2',
          '200': '#fce96a',
          '300': '#faca15',
          '400': '#e3a008',
          '500': '#c27803',
          '600': '#9f580a',
          '700': '#8e4b10',
          '800': '#723b13',
          '900': '#633112',
        },
        green: {
          '50': '#f3faf7',
          '100': '#def7ec',
          '200': '#bcf0da',
          '300': '#84e1bc',
          '400': '#31c48d',
          '500': '#0e9f6e',
          '600': '#057a55',
          '700': '#046c4e',
          '800': '#03543f',
          '900': '#014737',
        },
        teal: {
          '50': '#edfafa',
          '100': '#d5f5f6',
          '200': '#afecef',
          '300': '#7edce2',
          '400': '#16bdca',
          '500': '#0694a2',
          '600': '#047481',
          '700': '#036672',
          '800': '#05505c',
          '900': '#014451',
        },
        blue: {
          '50': '#ebf5ff',
          '100': '#e1effe',
          '200': '#c3ddfd',
          '300': '#a4cafe',
          '400': '#76a9fa',
          '500': '#3f83f8',
          '600': '#1c64f2',
          '700': '#1a56db',
          '800': '#1e429f',
          '900': '#233876',
        },
        indigo: {
          '50': '#f0f5ff',
          '100': '#e5edff',
          '200': '#cddbfe',
          '300': '#b4c6fc',
          '400': '#8da2fb',
          '500': '#6875f5',
          '600': '#5850ec',
          '700': '#5145cd',
          '800': '#42389d',
          '900': '#362f78',
        },
        purple: {
          '50': '#f6f5ff',
          '100': '#edebfe',
          '200': '#dcd7fe',
          '300': '#cabffd',
          '400': '#ac94fa',
          '500': '#9061f9',
          '600': '#7e3af2',
          '700': '#6c2bd9',
          '800': '#5521b5',
          '900': '#4a1d96',
        },
        pink: {
          '50': '#fdf2f8',
          '100': '#fce8f3',
          '200': '#fad1e8',
          '300': '#f8b4d9',
          '400': '#f17eb8',
          '500': '#e74694',
          '600': '#d61f69',
          '700': '#bf125d',
          '800': '#99154b',
          '900': '#751a3d',
        },
      }
    },
    variants: {
      //backgroundColor: [\"responsive\", \"hover\", \"focus\", \"active\"]
    },
    plugins: [],
    purge: [
      '../lib/**/*.ex',
      '../lib/**/*.leex',
      '../lib/**/*.eex',
      './js/**/*.js'
    ],
  };" > tailwind.config.js
  ```
  
- In the assets directory, create app.scss in the css folder.

  ```
  echo "
  @tailwind base;
  @tailwind components;
  @tailwind utilities;
  " > css/app.scss
  ```

- Create custom.css

```
touch custom.css
echo "" >> custom.css
```

- In the assets directory, create app.css in the css folder.
 ```
 echo "/* This file is for your main application css. */
 @import \"../node_modules/nprogress/nprogress.css\";
 @import \"tailwindcss/base\";
 @import \"tailwindcss/components\";
 @import \"tailwindcss/utilities\";
 @import \"./custom.css\";
 " >> css/app.css
```

- Run using:
```
iex -S mix phx.server
```
