### Elixafast

A handy list of accelerators (commands/guides/links) for Elixir based Web Development.

### Phoenix Framework Links

- [Building a Real-Time Application in the Phoenix Framework with Elixir](https://earthly.dev/blog/real-time-phoenix-elixir/)
- [Adding Tailwind CSS to Phoenix 1.4 and 1.5](https://pragmaticstudio.com/tutorials/adding-tailwind-css-to-phoenix)
- [Phoenix Framework Source Code](https://github.com/phoenixframework/phoenix)
- [Phoenix Site](https://www.phoenixframework.org/)


### Commands to Get Started
```
mix phoenix_oauth2_provider.gen.templates # Generates PhoenixOauth2Provider templates
mix phx                                   # Prints Phoenix help information
mix phx.digest                            # Digests and compresses static files
mix phx.digest.clean                      # Removes old versions of static assets.
mix phx.gen.auth                          # Generates authentication logic for a resource
mix phx.gen.cert                          # Generates a self-signed certificate for HTTPS testing
mix phx.gen.channel                       # Generates a Phoenix channel
mix phx.gen.context                       # Generates a context with functions around an Ecto schema
mix phx.gen.embedded                      # Generates an embedded Ecto schema file
mix phx.gen.html                          # Generates controller, views, and context for an HTML resource
mix phx.gen.json                          # Generates controller, views, and context for a JSON resource
mix phx.gen.live                          # Generates LiveView, templates, and context for a resource
mix phx.gen.presence                      # Generates a Presence tracker
mix phx.gen.schema                        # Generates an Ecto schema and migration file
mix phx.gen.secret                        # Generates a secret
mix phx.new                               # Creates a new Phoenix v1.5.9 application
mix phx.new.ecto                          # Creates a new Ecto project within an umbrella project
mix phx.new.web                           # Creates a new Phoenix web project within an umbrella project
mix phx.routes                            # Prints all routes
mix phx.server                            # Starts applications and their servers
mix profile.cprof                         # Profiles the given file or expression with cprof
mix profile.eprof                         # Profiles the given file or expression with eprof
mix profile.fprof                         # Profiles the given file or expression with fprof
mix release                               # Assembles a self-contained release
mix release.init                          # Generates sample files for releases
mix run                                   # Starts and runs the current application
mix setup                                 # Alias defined in mix.exs
mix test                                  # Alias defined in mix.exs
mix test                                  # Runs a project's tests
mix test.coverage                         # Build report from exported test coverage
mix xref                                  # Prints cross reference information
iex -S mix                                # Starts IEx and runs the default task
```

### Pull Up Help

```
mix help phx.gen.live                     # Help on Generating Live Views
```

### Create App with Live View

```
mix phx.new --live <app_name>
```

### Generate LiveView, templates, and context for a resource.
Refer this [link](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Live.html) (to hexdocs) for details.
```
mix phx.gen.live <ContextModule> <SchemaModule> <schema_module_plural_name> <attribute_name>:<attribute_type> <attribute_name>:<attribute_type> ...
# Example
# mix phx.gen.live Accounts User users name:string age:integer
```


### Generate Complete Live View App (with Ecto and Node.js)
```
mix phx.new --live <app_name>
cd <app_name>

## Optional if dependecies not installed.
mix deps.get
mix deps.compile
cd assets && npm install && node node_modules/webpack/bin/webpack.js --mode development
cd ..
## Optional ends here.
mix ecto.create
mix phx.server
# Or 
# iex -S mix phx.server
```

### Other Useful Links

- [Supabase Realtime](https://github.com/supabase/realtime)
- [Elixir Style Guide](https://github.com/christopheradams/elixir_style_guide)
- [Absinthe : GraphQL Implementation for Elixir](https://github.com/absinthe-graphql/absinthe)
- [Poision : Json Library](https://github.com/devinus/poison)
- [Jason : JSON parser](https://github.com/michalmuskala/jason)
- [Bamboo : Email Library](https://github.com/thoughtbot/bamboo)
- [Swoosh : Email Composition, Delivery, Test](https://github.com/swoosh/swoosh)
- [httpoison : Http Client for Elixir](https://github.com/edgurgel/httpoison)
- [Mint: Http Client](https://github.com/elixir-mint/mint)
- [Floki :  Http Parser](https://github.com/philss/floki)
- [Broadway : Data Processing](https://github.com/dashbitco/broadway)
- [Timex : Data Time Library](https://github.com/dashbitco/broadway)
- [Livebook : Code Notebooks like Jupyter](https://github.com/livebook-dev/livebook)
- [libcluster : Cluster Formation and Healing](https://github.com/bitwalker/libcluster)
- [Überauth : Authentication System](https://github.com/ueberauth/ueberauth)
- [Pow : Authentication and User Management](https://github.com/danschultzer/pow)
- [Manifold : Message Passing between Nodes](https://github.com/discord/manifold)
- [Sites Using LiveView](https://github.com/beam-community/awesome-phoenix-liveview)
- [Kitto : Interactive Dashboards](https://github.com/kittoframework/kitto)
- [Credo : Static Code Analysis](https://github.com/rrrene/credo)

### Community
- [Beam Community](https://github.com/beam-community)
- [Jose Valim](https://github.com/josevalim)
- [Allan MacGregor](https://github.com/amacgregor)
