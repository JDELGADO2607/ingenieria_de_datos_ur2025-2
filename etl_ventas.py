import pandas as pd
import sqlite3
from pathlib import Path

INPUT_CSV="ventas.csv"
OUTPUT_DB="ventas.db"
TABLE_NAME="ventas"


def clasificar(venta):
    if venta > 500:
        return "Alta"
    if venta>=100:
        return "Media"
    return "Baja"

def main():
    print("ETL:Inicio del proceso")
    #-----1.Extracción-------
    print("Lectura CSV",INPUT_CSV)
    df = pd.read_csv(INPUT_CSV)
    print("\nDatos Originales")
    print(df.head())
    #-----2.Transformación-------
    print("\nTransformando datos...")
    # Normalizar nombres de columnas por si acaso
    df.columns = [c.strip() for c in df.columns]
    # Asegurar tipos numéricos
    df['precio_unitario'] = pd.to_numeric(df['precio_unitario'], errors='coerce')
    df['cantidad'] = pd.to_numeric(df['cantidad'], errors='coerce')
    # Convertir fecha a datetime
    df['fecha'] = pd.to_datetime(df['fecha'], errors='coerce')
    # Eliminar filas sin cliente o sin precio válido o sin cantidad válida
    df = df.dropna(subset=['cliente', 'precio_unitario', 'cantidad'])
    # Estandarizar texto
    df['cliente'] = df['cliente'].str.title().str.strip()
    df['producto'] = df['producto'].astype(str).str.upper().str.strip()
    df['pais'] = df['pais'].astype(str).str.upper().str.strip()
    # Calcular total_venta
    df['total_venta'] = df['precio_unitario'] * df['cantidad']
    # Clasificar por rango de venta
    df['categoria_venta'] = df['total_venta'].apply(clasificar)
    print("\n--- Datos transformados (primeras filas) ---")
    print(df.head())
    # --- 3. LOAD ---
    print(f"\nCargando a base de datos SQLite: {OUTPUT_DB} (tabla: {TABLE_NAME})")
    conn = sqlite3.connect(OUTPUT_DB)
    df.to_sql(TABLE_NAME, conn, if_exists='replace', index=False)
    conn.close()
    print("Carga finalizada ✅")
    print("\nVerificación rápida:")
    conn = sqlite3.connect(OUTPUT_DB)
    preview = pd.read_sql(f"SELECT * FROM {TABLE_NAME} LIMIT 10", conn)
    print(preview)
    conn.close()
    print("=== ETL: fin ===")
    if __name__ == "__main__":
        main()