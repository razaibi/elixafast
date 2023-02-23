if [ $# -eq 0 ]; then
    >&2 echo "App Name (lowercase, example: hello)  not provided."
    exit 1
fi

sudo rm -r ./${1}/
docker stop postgres-db | xargs docker rm
docker run --name postgres-db -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres
mix phx.new ${1} --install
answer=${1}
./build_dev_config.sh ${1}

./build_areas.sh ${1}
./build_controller.sh ${1}
./build_template.sh ${1}
./build_router.sh ${1}

cd ${1}
mix ecto.create
mix ecto.migrate
iex -S mix phx.server