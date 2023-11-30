#!/bin/bash

INDEX_NAME="livros"
JQ="./dependencias/jq"
RESPOSTA="./temp1.json"
LIVROS_NDJSON="./temp2.jsonl"
LIVROS_JSON="./dependencias/livros_v1.json"
HEADER="Content-Type: application/x-ndjson"
FORMATA_JSON_PARA_NDJSON="./formata_livros_json_para_ndjson.sh"
ELASTIC_SEARCH="/home/csadm509/Develop/elasticsearch-5.6.5/bin/elasticsearch"