import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression
import matplotlib.pyplot as plt

# 1. Datos Históricos Aproximados (2010 - 2023)
# Fuente: Datos simulados basados en tendencias históricas del Banco Mundial
# PIB en Billones de USD (Trillions)
# Inflación en % anual

data = {
    'Year': [2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023],
    'GDP': [6.09, 7.55, 8.53, 9.57, 10.48, 11.06, 11.23, 12.31, 13.89, 14.28, 14.69, 17.82, 17.96, 17.70],
    'Inflation': [3.3, 5.4, 2.6, 2.6, 2.0, 1.4, 2.0, 1.6, 2.1, 2.9, 2.5, 0.9, 2.0, 0.2]
}

df = pd.DataFrame(data)

# Preparar variables para Regresión Lineal
X = df[['Year']]  # Variable independiente (Tiempo)
y_gdp = df['GDP'] # Variable dependiente 1
y_inf = df['Inflation'] # Variable dependiente 2

# 2. Crear y Entrenar Modelos
# Modelo para PIB
model_gdp = LinearRegression()
model_gdp.fit(X, y_gdp)

# Modelo para Inflación
model_inf = LinearRegression()
model_inf.fit(X, y_inf)

# 3. Realizar Pronóstico (2025 - 2030)
future_years = np.array([[2025], [2026], [2027], [2028], [2029], [2030]])

pred_gdp = model_gdp.predict(future_years)
pred_inf = model_inf.predict(future_years)

# 4. Mostrar Resultados
print("-" * 50)
print("PRONÓSTICO MACROECONÓMICO CHINA (2025-2030)")
print("Modelo: Regresión Lineal Simple")
print("-" * 50)
print(f"{'Año':<10} | {'PIB (Billones USD)':<20} | {'Inflación (%)':<15}")
print("-" * 50)

results = []
for i, year in enumerate(future_years):
    gdp_val = pred_gdp[i]
    inf_val = pred_inf[i]
    print(f"{year[0]:<10} | {gdp_val:<20.2f} | {inf_val:<15.2f}")
    results.append({'Year': year[0], 'GDP': gdp_val, 'Inflation': inf_val})

print("-" * 50)
print("\nNota: La regresión lineal asume una tendencia constante.")
print("Los factores geopolíticos y crisis globales no están considerados en este modelo simple.")

# Opcional: Guardar a CSV si es necesario
# pd.DataFrame(results).to_csv('china_forecast_2025_2030.csv', index=False)
