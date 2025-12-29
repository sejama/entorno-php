echo -e "Desea realizar \033[36mbuild\033[0m al entorno?"
select yn in "Si" "No" "Cancelar"; do
    case $yn in
        Si ) echo -e "\033[33mRealizando build...\033[0m";
                docker build --no-cache -t php-apache . 
                echo 'Levantando entorno...espere'
                docker compose pull && docker compose -f docker-compose.yml up -d --remove-orphans
                break;;
        No ) echo 'Levantando entorno...espere'
        docker compose pull && docker compose -f docker-compose.yml up -d --remove-orphans
            break;;
        Cancelar )  exit;;
    esac
done
