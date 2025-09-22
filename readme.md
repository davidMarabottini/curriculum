# One Page CV con Apache FOP

Questo progetto genera un pdf partendo da dati strutturati in XML e trasformandoli con xslt/xsl-fo

## Struttura del progetto

```
.
├── onepagecv.xsl                # Struttura del curriculum (XSLT/XSL-FO)
├── launch.txt                   # Esempio di comando per generare il PDF
├── dummy.xml                    # File XML vuoto, richiesto da FOP
├── .gitignore                   # Esclusione file sensibili
├── constants/                      
│   ├── colors.xsl           
│   ├── fonts.xsl        
│   ├── spacing.xsl
│   └── index.xsl
├── components/                      
│   ├── link.xsl           
│   ├── progress-bar.xsl        
│   ├── rating.xsl
│   ├── sottotitolo.xsl
│   ├── titolo-sezione.xsl
│   └── index.xsl
└── david_marabottini/           # Cartella dati personali
    ├── dati_personali.xml       # ⚠️ NON va su git o ci va vuota; il consiglio è inserirla nel .gitignore (contiene dati sensibili)
    ├── skills_chart.ipynb       # Notebook Python per generare grafico a ragnatela
    ├── skills_chart.svg         # Grafico esportato in SVG (incluso nel CV)
    ├── it/                      # Cartella lingua IT
    │   ├── labels.xml           # Etichette localizzate
    │   ├── onepagecv.xml        # Dati CV in italiano
    │   └── cv_david_one_page.pdf# Curriculum generato in IT
    └── en/                      # Cartella lingua EN (se presente)
```

## Prerequisiti
* [Apache fop 2.7+](https://xmlgraphics.apache.org/fop/2.7/)
* [Java 11+ (necessario per fop)](https://adoptium.net/)
* [Python 3.12+ (per la generazione del grafico a barre)](https://www.python.org/downloads/)

## Generazione del CV
La struttura sulla quale sono i dati per generare il cv si basa su un sistema:
* una cartella di primo livello pensata per contenere tutte le informazioni necessarie al cv che si vuol generare
* più cartelle al secondo livello per gestire il multilingua

Queste 2 cartelle sono di default gestite da xsl nelle seguenti variabili

```
  <xsl:param name="root_folder" select="'david_marabottini'"/>
  <xsl:param name="lang" select="'it'"/>
  <xsl:param name="data" select="'onepagecv.xml'"/>
```
è possibile modificare i valori di default modificandoli all'interno oppure customizzarli tramite l'attributo param durante la generazione

```
-xml dummy.xml -xsl onepagecv.xsl -param root_folder "john_smith" -param lang "en" -pdf ./john_smith/en/cv_david_one_page.pdf
```

Se i parametri coincidono con quanto riportato nel file, l'attributo -param si può omettere

```
-xml dummy.xml -xsl onepagecv.xsl -pdf ./john_smith/en/cv_david_one_page.pdf
```

## Skills chart
Come è possibile vedere, nel curriculum è presente uno skill chart.

Questo è generato tramite un notebook jupiter david_marabottini/skills_chart.ipynb

Andrà quindi modificato il dizionario

```
skills = {
    'Frontend': 9,
    'ML e DL': 8,
    'Scrum': 8,
    'SQL': 8,
    'Matematics': 7
}
```
con valori da 0 a 10, lanciato lo script e salvato il file (in genere gli strumenti che leggono questi notebook hanno scorciatoie per effettuare il salvataggio)

poi andrà riportato il notebook nell'xml di base
```
<skillsspiderweb>./david_marabottini/skills_chart.svg</skillsspiderweb>
```

## note su privacy
è stato predisposto un xml datipersonali.xml per gestire dati relativi alla privacy (email, telefono ecc), qualora vogliate creare una fork è bene assicurarsi che esso sia incluso nel gitignore prima di pushare, e, volendo inserire esempi, verificare che nei pdf non compaiano