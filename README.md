# Instructions to install the .dotfiles

## Clone the repository

In your HOME directory, run:

`git clone https://github.com/thalesnunes/.dotfiles.git`

## Run the install_packages.sh script to install the required packages

`./install_packages.sh`

## Run the install_dotfiles.sh script to install dotfiles

`./install_dotfiles.sh`

To deploy root configuration files to `/` (copied directly instead of symlinked):

`./install_dotfiles.sh --root`

## Run the install_setup.sh script to configure system services and desktop settings

`./install_setup.sh`

Happy coding!
