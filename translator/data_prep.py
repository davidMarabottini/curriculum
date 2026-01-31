import sys
import xml.etree.ElementTree as ET

# --- VARIABILI GLOBALI (Risultati della scansione) ---
# Mappa per associare un riferimento univoco (XPath) al testo originale
xpath_to_text_map = {} 
# Lista semplice contenente solo i testi da inviare all'API
texts_to_translate_list = [] 
# Lista per mantenere l'ordine degli elementi scansionati (necessario per la ricostruzione)
element_references = [] 

# --- FUNZIONE AUSILIARIA ---
def get_xpath(element):
    """
    Funzione per ottenere un XPath univoco per un elemento.
    Nota: l'implementazione ET standard non ha un metodo 'getpath' robusto come lxml.
    Per semplicità, usiamo una navigazione di base. Se necessario, lxml fornisce 
    un metodo `ElementTree.getpath()`, ma richiede un'installazione separata.
    Per questo esercizio, simuliamo il percorso.
    """
    # Questo è un placeholder che funziona bene con ET e tag non ripetuti allo stesso livello.
    return ET.ElementTree(element).getpath(element)

# --- FUNZIONE PRINCIPALE ---
def prepare_translation_batch(input_file, xpath_start_tag):
    """
    Carica l'XML, naviga fino all'XPath specificato, e crea la lista di batch
    e la mappa di riferimento.
    """
    global xpath_to_text_map, texts_to_translate_list, element_references

    try:
        tree = ET.parse(input_file)
        root = tree.getroot()
    except Exception as e:
        print(f"Errore di parsing del file XML '{input_file}': {e}")
        sys.exit(1)
        
    print(f"File caricato. Punto di inizio XPath: '{xpath_start_tag}'")

    # 1. Trova il punto di partenza (nodo genitore) usando find() che supporta XPath
    start_element = root.find(xpath_start_tag)
    
    if start_element is None:
        # Se l'XPath non punta all'elemento radice, prova a cercarlo in modo completo.
        # Ad esempio, se l'utente mette 'progetti-personali' ma non '/curriculum/...'
        if xpath_start_tag == root.tag:
             start_element = root
        else:
            print(f"ERRORE: Nessun elemento trovato con l'XPath '{xpath_start_tag}'.")
            sys.exit(1)

    # 2. Iterazione Ricorsiva a partire dal nodo trovato (inclusi i sotto-elementi)
    # Usiamo start_element.iter() per trovare tutti i discendenti, incluso se stesso.
    for elem in start_element.iter():
        
        # Ignoriamo il tag di inizio se non contiene testo (come <curriculum> o <progetti-personali>)
        if elem == start_element and not (elem.text and elem.text.strip()):
            continue
        
        # 3. Estrai e Pulisci Testo (Contenuto del tag)
        if elem.text and elem.text.strip():
            original_text = elem.text.strip()
            
            # FILTRO DI EFFICIENZA: Ignora i dati che non devono mai essere tradotti
            if not original_text.startswith(('http', 'https', './', '://')) and not original_text.replace('.', '').isdigit():
                
                # Questa è la chiave per la ricostruzione corretta
                xpath_key = get_xpath(elem) 
                
                # Aggiungi alla lista batch (efficiente)
                texts_to_translate_list.append(original_text)
                
                # Aggiungi alla mappa di riferimento (necessaria per il post-processing)
                # Salviamo il tag e il testo, e il riferimento all'oggetto per la ricostruzione.
                xpath_to_text_map[xpath_key] = {
                    'original_text': original_text,
                    'element': elem, # Manteniamo il riferimento all'oggetto ET
                    'type': 'text'
                }

        # 4. Estrai e Pulisci Coda (Testo dopo il tag di chiusura - utile per indentazione)
        # Questo è meno comune ma necessario per l'accuratezza strutturale
        if elem.tail and elem.tail.strip():
            original_tail = elem.tail.strip()
            # Non filtriamo pesantemente il tail, perché di solito è solo spazio
            
            xpath_key = get_xpath(elem) + '::tail'
            
            texts_to_translate_list.append(original_tail)
            xpath_to_text_map[xpath_key] = {
                'original_text': original_tail,
                'element': elem,
                'type': 'tail'
            }

# --- ESECUZIONE ---
if __name__ == "__main__":
    
    # Verifica il numero di argomenti
    if len(sys.argv) < 3:
        print(f"Uso: python {sys.argv[0]} <input_file.xml> <xpath_start_tag>")
        print("\nEsempio 1 (Traduzione Etichette):")
        print(f"  python {sys.argv[0]} profiles/david_marabottini_expanded/it/labels.xml /labels/*")
        print("\nEsempio 2 (Traduzione Progetti):")
        print(f"  python {sys.argv[0]} dummy.xml /curriculum/progetti-personali")
        sys.exit(1)

    # Assegna gli argomenti
    input_file = sys.argv[1]
    xpath_tag = sys.argv[2] 
    
    # Esegue la preparazione
    prepare_translation_batch(input_file, xpath_tag)

    # --- RISULTATI ---
    print("\n" + "="*50)
    print("✅ PRE-PROCESSING COMPLETATO E PRONTO PER IL BATCHING")
    print("="*50)
    print(f"Totale stringhe da tradurre in batch: {len(texts_to_translate_list)}")
    print(f"Caratteri totali stimati per API: {sum(len(t) for t in texts_to_translate_list)}")
    
    print("\nEsempio di Mappa (XPath Unico -> Testo Originale):")
    # Stampa i primi 5 elementi della mappa
    for i, (xpath, data) in enumerate(xpath_to_text_map.items()):
        if i >= 5: break
        print(f"  [{data['type'].upper()}] {xpath}: '{data['original_text'][:50]}...'")

    print("\nLa lista 'texts_to_translate_list' è ora pronta per la chiamata API in blocco.")

# Il prossimo passo sarebbe integrare la chiamata API e la ricostruzione dell'XML.

# import xml.etree.ElementTree as ET

# # Il file di input
# INPUT_FILE = 'profiles/david_marabottini_expanded/it/labels.xml' 

# tags_to_text_map = {}
# text_to_translate_list = []

# try:
#     tree = ET.parse(INPUT_FILE)
#     root = tree.getroot()
# except Exception as e:
#     print(f"Errore di parsing XML: {e}")
#     exit()

# for elem in root.iter():
#     if elem.tag == 'labels':
#         continue
    
#     original_text = elem.text.strip() if elem.text else ""
#     tag_name = elem.tag
    
#     if original_text:
#         tags_to_text_map[tag_name] = original_text
        
#         text_to_translate_list.append(original_text)

# print("Preparazione completata.")
# print(f"Totale elementi da tradurre: {len(text_to_translate_list)}")

# print("\nEsempio di Mappatura (Tag -> Testo):")
# for tag, text in list(tags_to_text_map.items())[:3]:
#     print(f"  <{tag}>: '{text}'")

# print("\nLista finale da inviare all'API (Input Batch):")
# print(text_to_translate_list)
