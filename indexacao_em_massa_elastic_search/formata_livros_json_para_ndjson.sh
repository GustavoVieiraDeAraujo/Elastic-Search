#!/bin/bash

source variaveis.sh

formata_json_para_ndjson() {
    local index_name=$1
    local doc_type=$2
    local title=$3
    local author=$4
    local publication_year=$5
    local genre=$6
    local synopsis=$7

    printf '{"index": {"_index": "%s", "_type": "%s"}}\n' "$index_name" "$doc_type"
    printf '{"titulo": "%s", "autor": "%s", "ano_publicacao": %d, "genero": "%s", "sinopse": "%s"}\n' "$title" "$author" "$publication_year" "$genre" "$synopsis"
}

cat "$LIVROS_JSON" | "$JQ" -c '.livros[]' | while read -r line; do
    titulo=$("$JQ" -r '.titulo' <<< "$line")
    autor=$("$JQ" -r '.autor' <<< "$line")
    ano_publicacao=$("$JQ" -r '.ano_publicacao' <<< "$line")
    genero=$("$JQ" -r '.genero' <<< "$line")
    sinopse=$("$JQ" -r '.sinopse' <<< "$line")

    formata_json_para_ndjson "$INDEX_NAME" "$genero" "$titulo" "$autor" "$ano_publicacao" "$genero" "$sinopse"
done