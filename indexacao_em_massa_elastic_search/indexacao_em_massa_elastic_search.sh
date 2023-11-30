#!/bin/bash

source variaveis.sh
source "../config_elastic_search/on_off_elastic_search.sh"

post_em_massa() {
    local url="$1"
    local json="$2"

    echo -e "Realizando requisição POST para: $url\n"

    if [ -f "$JQ" ]; then
        if [ -f "$LIVROS_JSON" ]; then
            echo -e "Formatando JSON para NDJSON/n"
            bash "$FORMATA_JSON_PARA_NDJSON" > "$LIVROS_NDJSON"
            echo -e "Formatacao finalizada/n"
        else
            echo "O arquivo $LIVROS_JSON não foi encontrado."
        fi
    else
        echo "O arquivo jq não foi encontrado em $JQ."
    fi

    curl -s -XPOST "$url" -H "$HEADER" --data-binary "@$LIVROS_NDJSON" > "$RESPOSTA" &
    
    tempo_limite=10
    tempo_passado=0

    while [ $tempo_passado -lt $tempo_limite ] && [ ! -s "$RESPOSTA" ]; do
        sleep 1
        tempo_passado=$((tempo_passado+1))
    done

    if [ -s "$RESPOSTA" ]; then
        rm -f "$LIVROS_NDJSON"
        echo -e "\nRequisição concluída!\n"
        cat "$RESPOSTA"
        rm -f "$RESPOSTA"
        echo -e "\n"
    else
        echo -e "\nTempo limite atingido. A requisição ainda não foi concluída\n"
    fi
}

forcar_atualizacao_index(){
    
}

delete() {
    local url="$1"

    echo -e "Realizando requisição DELETE para: $url\n"
    curl -s -XDELETE "$url" > "$RESPOSTA" &

    tempo_limite=10
    tempo_passado=0

    while [ $tempo_passado -lt $tempo_limite ] && [ ! -s "$RESPOSTA" ]; do
        sleep 1
        tempo_passado=$((tempo_passado+1))
    done

    if [ -s "$RESPOSTA" ]; then
        echo -e "\nRequisição concluída!\n"
        cat "$RESPOSTA"
        rm -f "$RESPOSTA"
        echo
    else
        echo -e "\nTempo limite atingido. A requisição ainda não foi concluída\n"
    fi
}

inicia_elastic_search

post_em_massa "http://localhost:9200/livros/_bulk?pretty" "$LIVROS_JSON"
delete "http://localhost:9200/livros"

finaliza_elastic_search