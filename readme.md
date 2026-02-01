# One Page CV con Apache FOP

Questo progetto genera PDF a partire da dati XML strutturati, trasformati tramite XSLT/XSL-FO, con supporto multilingua, template selezionabili e componenti modulari.

---

## Struttura del progetto

```
.
├── index.xsl                 # Entry point XSLT
├── launch.txt                    # Esempio di comando per generare il PDF
├── dummy.xml                     # File XML vuoto richiesto da FOP
├── .gitignore                    # Esclusione file sensibili
├── constants/                     # Costanti condivise
│   ├── colors.xsl
│   ├── fonts.xsl
│   ├── spacing.xsl
│   └── index.xsl
├── components/                    # Componenti modulari
│   ├── 01-atoms/                  # Elementi base riutilizzabili
│   │   ├── link.xsl
│   │   ├── progress-bar.xsl
│   │   ├── rating.xsl
│   │   ├── sottotitolo.xsl
│   │   └── titolo-sezione.xsl
│   ├── 02-molecules/              # Combinazioni di atoms
│   │   └── conditional-link.xsl
│   └── 03-organisms/              # Blocchi complessi (header, paragrafi, skill chart, ecc.)
│       ├── header.xsl
│       ├── paragraph.xsl
│       ├── external-links.xsl
│       ├── skill-list.xsl
│       ├── languages.xsl
│       ├── certification.xsl
│       ├── radar-chart.xsl
│       └── radar-chart-ats.xsl
├── templates/                     # Template PDF
│   ├── index.xsl
│   ├── ats-template.xsl
│   └── human-template.xsl
└── profiles/                      # Dati personali e multilingua
    ├── david_marabottini/
    │   ├── dati_personali.xml     # ⚠️ NON va su git o va vuoto
    │   ├── skills_chart.ipynb     # Notebook Python per grafico a ragnatela
    │   ├── skills_chart.svg       # Grafico esportato in SVG
    │   ├── it/                    # Lingua italiana
    │   │   ├── labels.xml         # Etichette localizzate
    │   │   ├── onepagecv.xml      # Dati CV in italiano
    │   │   └── cv_david_one_page.pdf
    │   └── en/                    # Lingua inglese
    │       ├── labels.xml
    │       ├── onepagecv.xml
    │       └── cv_david_one_page.pdf
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
