''' Exploration des fichiers '''
from email.mime import text

import pandas as pd
from pathlib import Path

RAW_DATA_DIR = Path(__file__).resolve().parent.parent / "data"/"raw"

FICHIERS = ["olist_customers_dataset.csv",
         "olist_geolocation_dataset.csv",
         "olist_order_items_dataset.csv",
         "olist_order_payments_dataset.csv",
         "olist_order_reviews_dataset.csv",
         "olist_orders_dataset.csv",
         "olist_products_dataset.csv",
         "olist_sellers_dataset.csv",
         "product_category_name_translation.csv"]


def chargement_donnees(liste_fichiers):
    dict_df = dict()
    for nom_fichier in liste_fichiers:
        dict_df[nom_fichier] = pd.read_csv(RAW_DATA_DIR / nom_fichier)
    return dict_df

data = chargement_donnees(FICHIERS)

print(data)

def afficher_resume(df, nom_fichier:str ):
    print(nom_fichier)
    print("La shape du data set est",data[nom_fichier].shape)
    print("Les types de variables sont",data[nom_fichier].dtypes)
    print("Les valeurs manquantes",data[nom_fichier].isnull().sum())
    print("Visualusation des 10 premières variables ",data[nom_fichier].head(10))

for nom_fichier, df in data.items():
    afficher_resume(df, nom_fichier)









