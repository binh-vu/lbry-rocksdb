set -ex

mkdir -p dist

function build_wheel() {
    virtualenv --python=$1 venvs/python$1
    venvs/python$1/bin/pip install cython wheel
    venvs/python$1/bin/pip wheel . -f . -w dist
}

pip install virtualenv
build_wheel 3.8
build_wheel 3.9
build_wheel 3.10
