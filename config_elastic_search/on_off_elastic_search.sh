#!/bin/bash

ELASTIC_SEARCH="/home/csadm509/Develop/elasticsearch-5.6.5/bin/elasticsearch"

inicia_elastic_search() {
    echo -e "------------------------------------------------------------------------\n"
    echo -e "Iniciando Elasticsearch\n"
    $ELASTIC_SEARCH &

    echo -e "Armazenando ID do processo do Elasticsearch\n"
    ELASTICSEARCH_PID=$!

    echo -e "Aguardando até que o Elasticsearch esteja disponível na porta 9200\n"
    while ! nc -z localhost 9200; do  
        sleep 1
    done

    echo -e "\nElasticsearch iniciado com sucesso\n"
    echo -e "------------------------------------------------------------------------\n"
}

finaliza_elastic_search(){
    echo -e "------------------------------------------------------------------------\n"
    echo -e "Aguardando encerramento do Elasticsearch\n"
    kill $ELASTICSEARCH_PID
    while kill -0 $ELASTICSEARCH_PID 2>/dev/null; do
        sleep 1
    done
    echo -e "\nElasticsearch encerrado com sucesso\n"
    echo "------------------------------------------------------------------------"

}