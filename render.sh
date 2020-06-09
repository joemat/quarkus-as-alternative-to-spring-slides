rm -rf build && mkdir build

cp -r docs/images build

docker run -it --rm \
       -u $(id -u ${USER}):$(id -g ${USER}) \
       -v $(pwd)/build:/build \
       -v $(pwd)/docs:/documents/ \
       asciidoctor/docker-asciidoctor \
       asciidoctor-revealjs \
       -r asciidoctor-diagram \
       -a 'revealjsdir=https://cdn.jsdelivr.net/npm/reveal.js@3.9.2' \
       -D /build \
       slides.adoc

