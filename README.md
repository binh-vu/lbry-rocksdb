## lbry-rocksdb

### Note

The `python-rocksdb` and `pyrocksdb` packages haven't been updated in a long time - the repo lbry-rocksdb is a fork of python-rocksdb with many of the PRs to it merged, and with [bunch of updates and improvements](https://github.com/iFA88/python-rocksdb) from @iFA88 and @mosquito.

This repo is a fork from [lbry-rocksdb](https://github.com/lbryio/lbry-rocksdb) that I compiled lbry-rocksdb to use on Centos & Ubuntu. I also compiled expicitly with DEBUG_LEVEL=0.

### Install from pip

    pip install lbry-rocksdb

### Build instruction

1. Creating docker images to build this project
```
docker build -t rocksdb:centos7 -f Dockerfile.centos7 .
docker build -t rocksdb:ubuntu -f Dockerfile.ubuntu .
```

2. Compile && make wheels
```
docker run --rm -v $(pwd):/lbry-rocksdb -w /lbry-rocksdb -it rocksdb:centos7 bash -c 'make clean && make && bash scripts/make-wheels.sh'
docker run --rm -v $(pwd):/lbry-rocksdb -w /lbry-rocksdb -it rocksdb:ubuntu bash -c 'make clean && make && bash scripts/make-wheels.sh'
```

3. Upload them to pypi
```
twine upload  --skip-existing dist/lbry*.whl --verbose
```

If you are using mac, replace step 2 with:
```
export DEBUG_LEVEL=0
make clean && make && bash scripts/make-wheels-macos.sh
```
`make-wheels-macos.sh` script will rely on virtualenv to create different environments for the following python versions: 3.8, 3.9, 3.10. For virtualenv to create
an environment, it needs the corresponding python version that is automatically discovered by enumerating folders on the `PATH` environment variable ([see more](https://virtualenv.pypa.io/en/latest/user_guide.html#python-discovery)). So the easiest way is to modify `PATH`.
