#!/bin/bash

INDEX_NAME="livros"
RESPOSTA="./temp1.json"
LIVROS_NDJSON="./temp2.jsonl"
JQ="./povoando/dependencias/jq"
HEADER="Content-Type: application/x-ndjson"
LIVROS_JSON="./povoando/dependencias/livros_v2.json"
QUERY_FULL_TEXT='{"query": {"match": {"sinopse": "e a na" }}}'
FORMATA_JSON_PARA_NDJSON="./povoando/formata_livros_json_para_ndjson.sh"
QUERY_DSL_LIVROS='{"query": {"range": {"ano_publicacao": {"gte": 2000}}}}'
ELASTIC_SEARCH="/home/csadm509/Develop/elasticsearch-5.6.5/bin/elasticsearch"
QUERY_ANALITICA='{"size": 0, "aggs" : {"livros_por_autor" : {"terms" : {"field" : "autor.keyword"}}}}'
QUERY_ESTRUTURADA='{"query": {"bool": {"must": [{"range": {"ano_publicacao": {"gte": 1900}}},{"match": {"autor": "C.S. Lewis"}}]}}}'
