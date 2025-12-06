<h1 align="center">k3s Management Container</h1>

This is a dev container for managing a k3s server.
It installs kubectl and k9s and copies in your kube config

### Pre-requisites

<ul>
    <li>Install Visual Studio Code</li>
    <li>Install the 'Dev Containers' vscode extension</li>
    <li>Install podman</li>
</ul>

### Visual Studio Code

Just open this folder in VSCode and choose 'Re-open in container' when prompted.

Once the image has been built and the container is running you can use a terminal to run kubectl and / or k9s.


### PodMan

Move to the .devcontainer directory and build the image

```sh
cd .devcontainer

podman build -t k3s-manager-image .
```

Then run the container copying your kube config into the container an setting the KUBECONFIG environment variable

```sh
cd .devcontainer

podman run --rm -v ~/.kube/config:/root/.kube/config:ro -e KUBECONFIG=/root/.kube/config k3s-manager-image kubectl get pods -A

// or
cd .devcontainer

podman run -it -v ~/.kube/config:/root/.kube/config:ro -e KUBECONFIG=/root/.kube/config k3s-manager-image kubectl k9s

```

Add a shell function to ~/.bashrc

```sh
kctl() {
    # Check if any arguments were passed. If not, default to running k9s.
    if [ "$#" -eq 0 ]; then
        COMMAND="k9s"
    else
        # Otherwise, pass all arguments ($@) to kubectl
        COMMAND="kubectl $@"
    fi

    podman run -it --rm \
        -v ~/.kube/config:/root/.kube/config:ro \
        -e KUBECONFIG=/root/.kube/config \
        k3s-manager-image \
        $COMMAND
}
```

Then after

```sh
source ~/.bashrc
```

You can just use

```sh
kctl get nodes
```

or

```sh
kctl
```
to launch the k9s TUI