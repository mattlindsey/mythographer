# Mythographer README

Creative design and generation of myths.

This app will allow anyone to create unique stories and "worlds" based on elements from existing mythologies.
After selecting the desired elements (like gods, heroes, cultures, geography) a story will be created using artificial intellegence. Additional features could include generation of images, memes, or items of "lore."

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to develop:

  - [Project Setup](https://github.com/mattlindsey/mythographer/blob/main/PROJECT_SETUP.md)

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...

# Docker installation:

- Make sure you have docker installed on your machine in order to run this app using docker.

## Steps are necessary to get the application up and running with docker.

### Setup the application from scratch

    make setup

### Start the application in a docker container.

    make up

### Stop the application running in the docker container.

    make down

### Show the status of the containers running the application (Helpful for troubleshooting docker containers).

    make status

### Migrate the database.

    make migrate

### Show rails routes.

    make routes

### Start rails console in container.

    make console

### Run bundle (executes make down && make up commands)

    make bundle
