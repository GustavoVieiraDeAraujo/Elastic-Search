#!/bin/bash

source "../config_elastic_search/on_off_elastic_search.sh"

RESPOSTA="temp1.json"
HEADER="Content-Type: application/json"
ELASTIC_SEARCH="/home/csadm509/Develop/elasticsearch-5.6.5/bin/elasticsearch"

get() {
    local url="$1"

    echo -e "Realizando requisição GET para: $url\n"
    curl -s -XGET "$url" > "$RESPOSTA" &

    tempo_limite=10
    tempo_passado=0

    while [ $tempo_passado -lt $tempo_limite ] && [ ! -s "$RESPOSTA" ]; do
        sleep 1
        tempo_passado=$((tempo_passado+1))
    done

    if [ -s "$RESPOSTA" ]; then
        echo -e "Requisição concluída!\n"
        cat "$RESPOSTA"
        rm -f "$RESPOSTA"
        echo
    else
        echo -e "\nTempo limite atingido. A requisição ainda não foi concluída\n"
    fi
}

put() {
    local url="$1"
    local json="$2"

    echo -e "Realizando requisição PUT para: $url\n"
    curl -s -XPUT "$url" -H "$HEADER" -d "$json" > "$RESPOSTA" &

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
        echo -e "\n"
    else
        echo -e "\nTempo limite atingido. A requisição ainda não foi concluída\n"
    fi
}

post() {
    local url="$1"
    local json="$2"

    echo -e "Realizando requisição POST para: $url\n"
    curl -s -XPOST "$url" -H "$HEADER" -d "$json" > "$RESPOSTA" &

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
        echo -e "\n"
    else
        echo -e "\nTempo limite atingido. A requisição ainda não foi concluída\n"
    fi
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

echo -e "------------------------------------------------------------------------\n"
JSON_AMOR_NAS_COLINAS='{"titulo": "Amor nas Colinas", "autor": "Isabella Montenegro", "ano_publicacao": 2022, "genero": "Romance", "sinopse": "Em meio às paisagens deslumbrantes das colinas, duas almas se encontram e enfrentam desafios para viver um amor proibido."}'
put "http://localhost:9200/livros/romance/1?pretty" "$JSON_AMOR_NAS_COLINAS"
echo -e "------------------------------------------------------------------------\n"
JSON_SENHOR_DOS_ANEIS='{"titulo": "O Senhor dos Anéis","autor": "J.R.R. Tolkien","ano_publicacao": 1954,"genero": "Fantasia","sinopse": "A história da Terra-média e a busca pelo Um Anel que governa todos os outros anéis."}'
post "http://localhost:9200/livros/fantasia/?pretty" "$JSON_SENHOR_DOS_ANEIS"
echo -e "------------------------------------------------------------------------\n"
get "http://localhost:9200/livros/_search?pretty"
echo -e "------------------------------------------------------------------------\n"
delete "http://localhost:9200/livros?pretty"
echo -e "------------------------------------------------------------------------\n"

finaliza_elastic_search