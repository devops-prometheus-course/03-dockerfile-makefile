# kbot
devops application from scratch

### Building Instructions

#### You need to set Telegram token

```sh
export TELE_TOKEN=
```

#### use `ARCH=amd64` or `arm64` for setting architecture and `OS` for setting operation system(ex. `linux`, `windows`, and `darwin`)

##### Building locally

```sh
make linux ARCH=amd64
```

##### Building docker image

```sh
make image OS=windows ARCH=amd64
```

##### Pushing docker image to the registry

```sh
make push OS=windows ARCH=amd64
```