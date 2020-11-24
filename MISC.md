# Miscelâneas

## Gerando o projeto

Vou usar a versão mais recente do elixir através do docker para instalar phoenix e criar aplicação. Importante que seja montado o volume adequadamente.

```bash
docker run -it --rm -v $(pwd):/workspace elixir sh
```

E de dentro do container:
```bash
$ cd /workspace
$ mix local.hex
Are you sure you want to install "https://repo.hex.pm/installs/1.10.0/hex-0.20.6.ez"? [Yn] Y
* creating /root/.mix/archives/hex-0.20.6
$ mix archive.install hex phx_new 1.5.7
Resolving Hex dependencies...
Dependency resolution completed:
New:
  phx_new 1.5.7
* Getting phx_new (Hex package)
All dependencies are up to date
Compiling 10 files (.ex)
Generated phx_new app
Generated archive "phx_new-1.5.7.ez" with MIX_ENV=prod
Are you sure you want to install "phx_new-1.5.7.ez"? [Yn] Y
* creating /root/.mix/archives/phx_new-1.5.7

$ mix phx.new --live --database=postgres investire
* creating investir/config/config.exs
* creating investir/config/dev.exs
* creating investir/config/prod.exs
(...)

We are almost there! The following steps are missing:

    $ cd investir
    $ mix deps.get
    $ cd assets && npm install && node node_modules/webpack/bin/webpack.js --mode development

Then configure your database in config/dev.exs and run:

    $ mix ecto.create

Start your Phoenix app with:

    $ mix phx.server

You can also run your app inside IEx (Interactive Elixir) as:

    $ iex -S mix phx.server
```
