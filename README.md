# k8po-cli

## Installation Options

1. Clone the repo and run the `install.sh` script
1. Run `install.sh` directly from the web and let it self-install
    ```
    bash -c "$(curl https://raw.githubusercontent.com/johncornish/k8po-cli/main/install.sh)"

## Environment Configuration

`RUN_CHECKS`: whether to run `install.sh` from within `k8po`.
Set to `ci` to disable run, which will disable update.

`NON_INTERACTIVE`: any time a confirmation is presented to user,
automatically answer yes.
