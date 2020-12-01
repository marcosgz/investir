# Investir

## Configurar

Recomendo subir aplicação usando docker-compose. Para isso copie o arquivo `docker-compose.sample.yml` para `docker-compose.yml` e edite de acordo.

Para subir aplicação basta usar o comando:
```
docker-compose up
```

Na primeira execução será necessário rodar as migrações do banco de dados e executar o seed. Para isso utilize o comando:

```
docker-compose exec app mix setup
```

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
