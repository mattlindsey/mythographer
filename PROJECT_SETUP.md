# Setting Up for Development

These are the steps for setting up your development environment.

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

3. Updating your fork from original repo to keep it up to date

   ```bash
   git pull upstream main
   ```

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

####

If you get an error concerning Turbo or Redis, you may need to do
```bash
bin/rails turbo:install
bin/rails turbo:install:redis
redis-server --daemonize yes
```

## Code Style

We recommend and follow the [Ruby Style Guide](https://github.com/rubocop-hq/ruby-style-guide)
