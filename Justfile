image_name   := env_var_or_default("IMAGE_NAME", "rp-pico-sdk")
project_name := "blink"

# https://stackoverflow.com/questions/23513045/how-to-check-if-a-process-is-running-inside-docker-container
is_in_docker := `test -f /.dockerenv && echo 1 || echo 0`

# run_cmd is the docker run command used to launch your env.
run_cmd := if is_in_docker == "0" {
    'docker run -it --rm --mount type=bind,src="$(pwd)",target="/home/dev/project" -w /home/dev/project ' + image_name
} else {""}

#################

echo-run-cmd:
    @echo run_cmd={{run_cmd}}

check-in-docker:
    @echo {{if is_in_docker == "1" {"In docker container!"} else  {"Not in docker container!"} }}

ensure-folders:
    @mkdir -p build

build-docker force="no": ensure-folders
    #!/usr/bin/env sh
    if [ {{is_in_docker}} -eq 1 ] ; then
        echo "Running in docker container, skipping image generation !"
    else
        if [ -z `docker image ls {{image_name}} --format '1'`] || [ {{force}} = "force" ] ; then
            [ {{force}} = "force" ] && echo "Forcing build"
            docker buildx build --load -t {{image_name}} -f Dockerfile .
        fi
    fi

#################

configure: build-docker ensure-folders
	{{run_cmd}} cmake -GNinja -B build .

build: configure
	{{run_cmd}} cmake --build build

shell: build-docker
	{{run_cmd}} ash

flash: build
	@mkdir -p build/mnt
	sudo mount -t auto /dev/disk/by-label/RPI-RP2 build/mnt
	sudo cp build/{{project_name}}.uf2 build/mnt && sudo sync
	sudo umount build/mnt

clean:
	rm -r build
