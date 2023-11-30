#!/bin/bash

# Começa no './povoando/indexacao_em_massa_elastic_search.sh'

source variaveis.sh
source "./povoando/indexacao_em_massa_elastic_search.sh"

get_query_string () {
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

get_query_dsl () {
    local url="$1"
    local query="$2"

    echo -e "Realizando requisição GET para: $url\n"
    curl -s -XGET "$url" -d "$query" > "$RESPOSTA" &

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

# Estrutura de Pesquisas

echo -e "------------------------------------------------------------------------\n"
get_query_dsl "http://localhost:9200/livros/_search?pretty" "$QUERY_DSL_LIVROS"
echo -e "------------------------------------------------------------------------\n"

echo -e "------------------------------------------------------------------------\n"
get_query_string "http://localhost:9200/livros/_search?q=ano_publicacao:>=2000&pretty"
echo -e "------------------------------------------------------------------------\n"

# Tipos de Pesquisa

# DSL + FULL-TEXT

echo -e "------------------------------------------------------------------------\n"
get_query_dsl "http://localhost:9200/livros/fantasia/_search?pretty" "$QUERY_FULL_TEXT"
echo -e "------------------------------------------------------------------------\n"

# DSL + ESTRUTURADA

echo -e "------------------------------------------------------------------------\n"
get_query_dsl "http://localhost:9200/livros/infantil/_search?pretty" "$QUERY_ESTRUTURADA"
echo -e "------------------------------------------------------------------------\n"

# DSL + ANALITICA

echo -e "------------------------------------------------------------------------\n"
get_query_dsl "http://localhost:9200/livros/_search?pretty" "$QUERY_ANALITICA"
echo -e "------------------------------------------------------------------------\n"

echo -e "------------------------------------------------------------------------\n"
delete "http://localhost:9200/livros?pretty"
echo -e "------------------------------------------------------------------------\n"

finaliza_elastic_search