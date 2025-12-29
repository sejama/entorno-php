echo ""
echo -e "Recuerde que puede volver a ejecutar \033[32m ./setup.sh\033[0m para cambiar la configuración."
echo ""
echo -e "Desea agregar \033[36mRedis\033[0m al entorno?"
select yn in "Si" "No" "Cancelar"; do
    case $yn in
        Si ) echo -e "\033[33mAgregando motor Redis ...\033[0m";
                docker_compose_redis=' -f docker-compose-redis.yml';
                break;;
        No ) docker_compose_redis='';
            break;;
        Cancelar )  exit;;
    esac
done

echo
echo -e "Desea agregar \033[36mPostgreSQL\033[0m al entorno?"
select yn in "Si" "No" "Cancelar"; do
    case $yn in
        Si ) echo -e "\033[33mAgregando motor PostgreSQL ...\033[0m";
                [ -d pgadmin/data ] && echo  || mkdir -p -m=777 pgadmin/data;
                docker_compose_postgres=' -f docker-compose-postgres.yml';
                break;;
        No ) docker_compose_postgres='';
            break;;
        Cancelar )  exit;;
    esac
done

echo
echo -e "Desea agregar \033[36mMySQL\033[0m al entorno?"
select yn in "Si" "No" "Cancelar"; do
    case $yn in
        Si ) echo -e "\033[33mAgregando motor MySQL ...\033[0m"; 
            docker_compose_mysql=' -f docker-compose-mysql.yml';
            break;;
        No ) docker_compose_mysql='';
            break;;
        Cancelar )  exit;;
    esac
done

echo
echo -e "Desea agregar \033[36mSoporte Oracle\033[0m al entorno?"
select yn in "Si" "No" "Cancelar"; do
    case $yn in
        Si ) echo -e "\033[33mAgregando soporte Oracle ...\033[0m";
            docker_compose_web='docker-compose-oracle.yml';
            break;;
        No ) docker_compose_web='docker-compose.yml'; 
            break;;
        Cancelar )  exit;;
    esac
done


echo
echo -e "Desea agregar \033[36mRabbitMQ\033[0m al entorno?"
select yn in "Si" "No" "Cancelar"; do
    case $yn in
        Si ) echo -e "\033[33mAgregando RabbitMQ ...\033[0m";
            docker_compose_rabbitmq='-f docker-compose-rabbitmq.yml';
            break;;
        No ) docker_compose_rabbitmq='';
            break;;
        Cancelar )  exit;;
    esac
done


#escribe en el archivo iniciar.sh la configuración de entorno seleccionada
echo "echo 'Levantando entorno...espere'
docker-compose pull && docker-compose -f $docker_compose_web $docker_compose_redis $docker_compose_mysql $docker_compose_postgres $docker_compose_rabbitmq up -d --remove-orphans
sleep 1
docker exec --user desa web-server sudo -i /etc/init.d/php8.3-fpm start" > iniciar.sh

#escribe en el archivo bajar.sh la configuración de entorno seleccionada
echo "echo 'Bajando entorno...'
docker-compose -f $docker_compose_web $docker_compose_redis $docker_compose_mysql $docker_compose_postgres $docker_compose_rabbitmq down --remove-orphans" > bajar.sh

echo ""
echo "Fin de configuración de entorno. Ejecute ./iniciar.sh para inicializar."
echo ""

