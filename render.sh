rm -rf build && mkdir build

cp -r docs/images build

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
       -a 'revealjsdir=https://cdn.jsdelivr.net/npm/reveal.js@3.9.2' \
       -D /build \
       slides.adoc

