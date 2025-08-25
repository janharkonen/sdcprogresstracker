# 🎵 SDC Taitomerkki -seurantajärjestelmä

Sovellus, joka mahdollistaa SMKL taitomerkin kappaleiden osaamistason seurannan kvartetille.

![Kuvakaappaus sovelluksesta](https://via.placeholder.com/800x400?text=SDC+Taitomerkki)

## 🚀 Deployaus

Nginx, Redis ja Svelte imaget on tallennettu omaan DockerHubiin julkisessa repositoriossa. Deployaus on tehty omaan VPS:ään käyttäen `vps_deploy` -kansion konffauksia. Ainoa asia mitä on lisättävä on `Caddyfile` pitäisi laittaa oma domain sekä tietenkin säätää omat DNS-asetukset.

### 💻 DEV

Devausympäristöön riittää, että laittaa komennon
```
make run_dev
```

### 🗄️ REDIS Database Structure

Redis is used as the primary data store with the following key structure:

| Key Type | Format | Example | Description |
|----------|--------|---------|-------------|
| **collection** | `` | `` | Laulukokoelma (taitomerkki, perusmerkki, etc.) |
| **group** | `` | `` | Kvartettiryhmä (sdc, gch, etc.) |
| **Biisilista** | `{collection}:{id}` | `taitomerkki:1`, `taitomerkki:2` | Yksittäiset kappaleet kokoelmasta |
| **Singer List** | `laulajat:{group}:{id}` | `laulajat:sdc:1`, `laulajat:sdc:2` | Ensemblen jäsenet |
| **Progress State** | `state:{group}` | `state:sdc` | Kyseisen ensemblen suoritustila |

### 📊 Suoritustila
Jokainen kappale jokaisella jäsenellä on oma suoritustasonsa asteikolta 0-3, eli binäärinä {0, 1, 2, 3} -> {00, 01, 10, 11}. Eli jokainen suoritustaso vie 2 bittiä. Taitomerkissa on 40 kappaletta ja laulajia on 4, joten suoritustasoja on yhteensä 160 kpl. Tämä tarkoittaa että koko systeemin tila voidaan ilmoittaa käyttämällä 320 bittiä. 

Esim. jos tämän systeemin tila olisi 010000000000001011001100


|  | Laulaja 1 | Laulaja 2 | Laulaja 3 | Laulaja 4 |
|----------|--------|---------|---------|---------|
| **Kappale 1** | 0 | 3 | 0 | 3 |
| **Kappale 2** | 2 | 0 | 0 | 0 |
| **Kappale 3** | 0 | 0 | 0 | 1 |

Hexsadesimaalina tämä olisi 802cc, joka tallentuu Redikseen stringinä. Tämähän ei ole informaatioteoreettisesti optimaalisinta, mutta elämä on.