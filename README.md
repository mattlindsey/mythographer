# Mythographer README

![Tests status](https://github.com/mattlindsey/mythographer/actions/workflows/ci.yml/badge.svg?branch=main)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/mattlindsey/mythographer/blob/main/LICENSE)

Creative design and generation of myths using artificial intelligence.

This app will allow anyone to create unique stories and "worlds" based on elements from existing mythologies.
After selecting the desired elements (like gods, heroes, cultures, geography) a story will be created using artificial intellegence. Additional features could include generation of images, memes, or items of "lore."

# Contributing

See [CONTRIBUTING.md](https://github.com/mattlindsey/mythographer/blob/main/CONTRIBUTING.md).

Working with this project is a good way to learn Ruby on Rails and AI LLMs (Large Language Models)!

# Setting Up for Development

These are the steps for setting up your development environment locally or using Docker.

### Step 1: Get your own local copy of the project to work on

You'll do your development work on your own forked copy of the project, so hit the 'clone' button in github.

#### Keeping a fork up to date

1. Clone your fork:

   ```bash
   git clone git@github.com:YOUR-USERNAME/YOUR-FORKED-REPO.git
   ```

2. Add remote from original repository in your forked repository:

   ```bash
   cd into/cloned/fork-repo
   git remote add upstream https://github.com/mattlindsey/mythographer.git
   git fetch upstream
   ```

3. Updating your fork frequently from original repo to keep it up to date

   ```bash
   git pull upstream main
   ```

4. If you want to use Docker, skip the following steps and jump right to [Docker Installation.](#docker-installation-optional)

### Step 2: Install the gems with `bundle install`

```bash
bundle install
```

#### PostgreSQL and the `pg` gem

The database used is [postgreSQL](https://www.postgresql.org/).  You need to have this installed and running on your local machine.

### Step 3: Set up the database and seed data

Run these commands;

```bash
bin/rails db:setup
bin/rails db:seed
```

### Step 4: Run the tests

Now you're ready to run the tests:

```bash
bin/rails test:all
```

### Step 5: Set your OpenAI key

```bash
export OPENAI_API_KEY=sk-key
```

### Step 6. Start the server

```bash
bin/rails dev
```

You can now see the system working [locally](http://localhost:3000)

If you get an error concerning Turbo or Redis, you may need to start Redis in the background

```bash
redis-server --daemonize yes
```

## Code Style

Before committing your code, ensure that it follows ruby and rails style standards

```bash
bundle exec rubocop -A
```

We recommend and follow the [Ruby Style Guide](https://github.com/rubocop-hq/ruby-style-guide)

# Docker installation (optional)

- Make sure you have docker installed on your machine in order to run this app using docker.

## Steps are necessary to get the application up and running with docker

```bash
make setup
```

### Start the application in a docker container

```bash
make up
```

### Stop the application running in the docker container

```bash
make down
```

### Show the status of the containers running the application (Helpful for troubleshooting docker containers)

```bash
make status
```

### Migrate the database

```bash
make migrate
```

### Show rails routes

```bash
make routes
```

### Start rails console in container

```bash
make console
```

### Run bundle (executes make down && make up commands)

```bash
make bundle
```
