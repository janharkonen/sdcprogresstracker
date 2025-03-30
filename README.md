# SDC Taitomerkki -seurantajärjestelmä

Sovellus, joka mahdollistaa SMKL taitomerkin kappaleiden osaamistason seurannan kvartetille.

![Kuvakaappaus sovelluksesta](https://via.placeholder.com/800x400?text=SDC+Taitomerkki)

## Asennus ja käyttöönotto

### PROD

Luo `.env` tiedosto ja laita `APP_WEBSOCKET_URL` kohtaan url, joka osoittaa `http://localhost:8080`. Itse tein sen konffaamalla omalla servulla `/etc/nginx/sites-enabled/[oma domain]`

```
APP_WEBSOCKET_URL='wss://[oma osoite]'
```

Docker kontit pyöritetään (ja kaadetaan) komennoilla
```
docker-compose --profile prod build
docker-compose --profile prod up
docker-compose --profile prod down
```

### DEV

Devausympäristössä riittää, että laittaa `.env` tiedostoon
```
APP_WEBSOCKET_URL='ws://localhost:8080'
```

Docker kontit pyöritetään (ja kaadetaan) komennoilla
```
docker-compose --profile dev build
docker-compose --profile dev up
docker-compose --profile dev down
```

## Kehitystä vaativat kohdat (Tekninen velka)

- UI: Table header voisi olla sticky
- UI: Tee matriisin nappuloista kaikki samanlevyisiä ja -korkuisia
- Websocket yhteys vois olla katkeamatta automaattisesti (laita joku pingi säännöllisin väliajoin)
- Käytä suoraan Redis-stackin JSON ominaisuutta
- CRON job servulle, joka backuppaa Redis tietokannan

## Lisenssi

MIT-lisenssi, katso [LICENSE](LICENSE)-tiedosto.