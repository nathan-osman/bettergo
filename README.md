## bettergo

The [`golang` repository](https://hub.docker.com/_/golang/) on Docker Hub is useful for building Go applications in a container without requiring the host to have the Go toolchain installed. Typical usage would look something like this:

    mkdir dist
    docker run \
        --rm \
        -v `pwd`/dist:/go/bin \
        golang \
        go get github.com/hectane/hectane

If successful, the `dist/` directory will contain an executable named `hectane` when the command completes.

One small problem: _`dist/hectane` is owned by root_.

You can still remove the directory with `rm` but even that will fail if there are subdirectories.

That's where bettergo comes in. Instead of running commands in the container as root, bettergo takes a completely different approach: create a user in the container that matches the current user on the host. What does this look like?

    mkdir dist
    docker run \
        --rm \
        -v `pwd`/dist:/go/bin \
        -e UID=`id -u` \
        nathanosman/bettergo \
        go get github.com/hectane/hectane

The only differences are the repository name and the addition of the environment variable `UID`, which is initialized with the current user's ID. The container will then create the appropriate entries in `/etc/passwd` and `/etc/shadow` for you and then run the `go get` command as the new user.

Once the command completes, everything inside `dist` is owned by... you! That's right, you are the owner of the files inside the directory once again.
