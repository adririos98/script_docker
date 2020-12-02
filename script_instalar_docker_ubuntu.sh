
 #!/bin/bash

        echo Instalación Docker
        sudo apt-get update
		sudo apt-get install curl
        echo Ahora vamos a instalar Docker. 
        sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
        sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
        echo     ***************************
        echo          Actualizando
        echo    ***************************
        sudo apt-get update

        echo    ************************************
        echo          INSTALAMOS DOKER-COMPOSE
        echo    ************************************
        sudo apt install docker.io

        echo    ***************************************
        echo          INSTALAMOS DOKER-COMPOSE
        echo    ***************************************
        sudo curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose

        echo    ******************************************
        echo            AÑADIMOS  USUARIO A DOCKER 
        echo    ******************************************
        sudo usermod -aG docker $(whoami)
		
		echo    ******************************************
        echo            AÑADIMOS  DCOKER-MACHINE
        echo    ******************************************
		curl -L https://github.com/docker/machine/releases/download/v0.7.0/docker-machine-`uname -s`-`uname -m` > /usr/local/bin/docker-machine && \
		chmod +x /usr/local/bin/docker-machine

    