# Pokémon Wiki

This is the Intro project for _Agile Full Stack Web Development_ course of **Red River College**

## Project setup
### 1. clone this repo
```shell
git clone https://github.com/LeopoldXing/rails_intro_project
```

### 2. cd into the project
```shell
cd rails_intro_project
```

### 3. install dependencies
```shell
gem install bundler
bundle install
```

### 4. setup database
#### create PostgreSQL database
```shell
docker compose up -d
```

#### insert sample data
This might take 5 - 10 min to complete.
```shell
rails db:seed
```

### 5. compile tailwindcss
```shell
rails tailwindcss:build
```

### 6. launch application
```shell
rails s
```

### 7. complete
now you can access the project in http://localhost:3000