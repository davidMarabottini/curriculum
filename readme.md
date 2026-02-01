# One Page CV con Apache FOP

Questo progetto genera PDF a partire da dati XML strutturati, trasformati tramite XSLT/XSL-FO, con supporto multilingua, template selezionabili e componenti modulari.

---

## Struttura del progetto

```
├── index.xsl
├── launch.txt
├── dummy.xml
├── .gitignore

├── src/
│   ├── constants/
│   │   ├── colors.xsl
│   │   ├── fonts.xsl
│   │   ├── spacing.xsl
│   │   └── index.xsl
│   ├── components/
│   │   ├── 01-atoms/
│   │   ├── 02-molecules/
│   │   └── 03-organisms/
│   └── templates/
│       ├── index.xsl
│       ├── ats-template.xsl
│       └── human-template.xsl

├── profiles/
│   └── david_marabottini/
│       ├── dati_personali.xml
│       ├── skills_chart.ipynb
│       ├── skills_chart.svg
│       ├── it/
│       └── en/

```

---

## Prerequisiti

* [Apache FOP 2.7+](https://xmlgraphics.apache.org/fop/2.7/)
* [Java 11+](https://adoptium.net/) (necessario per FOP)
* [Python 3.12+](https://www.python.org/downloads/) (per generare il grafico a ragnatela)

---

## Generazione del CV

Il CV è basato su:

* Cartella principale dei dati (`profiles/<nome_utente>`)
* Cartelle per le lingue (`it`, `en`, ecc.)
* Template selezionabile (`ats-template` o `human-template`)

I parametri XSLT di default sono:

```xml
<xsl:param name="root_folder" select="'profiles/david_marabottini'"/>
<xsl:param name="lang" select="'it'"/>
<xsl:param name="data" select="'onepagecv.xml'"/>
<xsl:param name="template" select="'human-template'"/>
```

Per personalizzare, si possono passare durante l’esecuzione:

```bash
fop -xml dummy.xml -xsl onepagecv.xsl \
    -param root_folder "profiles/john_smith" \
    -param lang "en" \
    -param template "ats-template" \
    -pdf ./profiles/john_smith/en/cv_john_one_page.pdf
```

Se si usano i valori di default, i parametri possono essere omessi:

```bash
fop -xml dummy.xml -xsl onepagecv.xsl -pdf ./profiles/david_marabottini/en/cv_david_one_page.pdf
```

---

## Template e modularità

* Gli **atoms** sono i mattoni base (titoli, link, rating, ecc.)
* Le **molecules** combinano più atoms con logica condizionale
* Gli **organisms** sono blocchi complessi riutilizzabili (header, paragrafi, liste competenze, lingue, certificazioni, grafici)
* I **template** definiscono il layout complessivo e possono essere estesi o aggiunti senza modificare i componenti

---

## Skills chart

* Generato con il notebook Jupyter `skills_chart.ipynb`
* Aggiornabile modificando il dizionario `skills` e rieseguendo il notebook
* Salvataggio automatico in SVG, poi referenziato nell’XML:

```xml
<skillsspiderweb>./profiles/david_marabottini/skills_chart.svg</skillsspiderweb>
```

---

## Multilingua

* Etichette centralizzate in `labels.xml` per ciascuna lingua
* Dati duplicati per lingua in `onepagecv.xml`
* Generazione PDF separata per lingua senza modificare XSLT

---

## Privacy

* I dati sensibili sono in `dati_personali.xml` (email, telefono, ecc.)
* Sempre incluso nel `.gitignore`
* Prima di pubblicare fork o PDF di esempio, verificare che nessun dato sensibile venga incluso
