# peat

PEAT - Programa de Educação Ambiental para o Trabalhador

# Run for chrome and send to Hosting
/pmsb4$ flutter channel
Flutter channels:
  master
  dev
* beta
  stable

/pmsb4$ flutter run -d chrome

/pmsb4$ flutter build web

/pmsb4$ firebase deploy --only hosting:peat

~~~

Todos os comandos juntos:

~~~

flutter clean && flutter run -d chrome

flutter clean && flutter build web && firebase deploy --only hosting:peat

~~~