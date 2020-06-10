#!/bin/sh

clean_build_dir() {
 rm -rf build && mkdir build
}

copy_images_to_build_dir()  {
  cp -r docs/images  build
}

OFFLINE_MODE=0
if [ "-for-offline-usage" = "$1" ]
then
  OFFLINE_MODE=1
fi

clean_build_dir
copy_images_to_build_dir

if [ "$OFFLINE_MODE" -eq 1 ]
then
  mkdir build/style
  curl -L https://github.com/hakimel/reveal.js/archive/3.9.2.tar.gz | tar -zxvf - -C build/style
  REVEALJSDIR="style/reveal.js-3.9.2"
else
  REVEALJSDIR='https://cdn.jsdelivr.net/npm/reveal.js@3.9.2'
fi

DOCKER_ARGS_ADD=""
if [ -t 1 ]
then
  echo "Running in terminal - adding -ti to docker parameters"
   DOCKER_ARGS_ADD="-ti"
fi

docker run --rm $DOCKER_ARGS_ADD \
       -u $(id -u ${USER}):$(id -g ${USER}) \
       -v $(pwd)/build:/build \
       -v $(pwd)/docs:/documents/ \
       asciidoctor/docker-asciidoctor \
       asciidoctor-revealjs \
       -r asciidoctor-diagram \
       -a "revealjsdir=$REVEALJSDIR" \
       -D /build \
       index.adoc
