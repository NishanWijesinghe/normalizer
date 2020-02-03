#!/usr/bin/env bash
# Installing the AWS CLI and Python SDK
# These commands are intended to be run on on MacOS

export WHOAMI=$(whoami);
export cmd=$1

install_docker() {
    hash docker 2>/dev/null || {
                echo ">>>>>>>Installing Docker for Mac>>>>>>>"
                curl -o ~/Downloads/Docker.dmg https://download.docker.com/mac/stable/Docker.dmg;
                open ~/Downloads/Docker.dmg;
                docker_instruction="${WHOAMI}, Complete Docker for Mac installation on your screen. After installation, Docker preferences must \
                must match your apps memeory requirements"
                say ${docker_instruction};
                echo ${docker_instruction};
            }

}

python3(){
    echo ">>>>>Checking python3>>>>>>"
    hash python3 2>/dev/null || { brew install python3; }
}

install_prerequisites() {
    echo ">>>>>If not installed, installing brew >>>>>>"
    hash brew 2>/dev/null || { /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; }
}


install_python_enum() {
    pip install --upgrade enum34 --user
}

if [ "$cmd" = 'uninstall' ]; then #Run if install_aws has errors
    uninstall
elif [ "$cmd" = 'unzip_aws' ]; then
    unzip_aws
elif [ "$cmd" = 'install_aws' ]; then # Required #1
    install_aws
elif [ "$cmd" = 'configure_aws' ]; then # Required #2
    configure_aws
elif [ "$cmd" = 'install_aws_tools' ]; then # Required #3
    install_aws_tools
elif [ "$cmd" = 'install_optional_tools' ]; then
    install_optional_tools
elif [ "$cmd" = 'install_docker' ]; then
    install_docker
elif [ "$cmd" = 'install_python_enum' ]; then
    install_python_enum
else
        echo ""
        echo "$1 :INVALID COMMAND."
        exit 1
fi

# Checking if ecs-cli --version matches latest git repo
# TODO. Check if ecs-cli --version != https://github.com/aws/amazon-ecs-cli/blob/master/VERSION then re-run installation
# install_ecs(). kinda sucks there's no pip install --upgrade ecs-cli


# TODO Check if aws cli update. Check local version matches git version, if not then run
#pip install awscli --upgrade --user

#In certain version of MacOS, errors can be resolved with:

#chmod +x /Library/Python/
#sudo pip install --upgrade pip
#hash python3 2>/dev/null || { brew install python3; }
#pip3 install --upgrade virtualenv
#
#hash freetype 2>/dev/null || { brew install freetype; }
#hash pkg-config 2>/dev/null || { brew install pkg-config; }

#########
#sudo pip install --user s4cmd --ignore-installed six
#I get the following warning :
#The directory '/Users/cmathis/Library/Caches/pip/http' or its parent directory is not owned by the current user and the cache has been disabled. Please check the permissions and owner of that directory. If executing pip with sudo, you may want sudo's -H flag.
#The directory '/Users/cmathis/Library/Caches/pip' or its parent directory is not owned by the current user and caching wheels has been disabled. check the permissions and owner of that directory. If executing pip with sudo, you may want sudo's -H flag.
#but it installs ok
###########


#chmod +x /usr/local/bin/s4cmd
