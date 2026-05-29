# 📦 Olist E-Commerce | Dashboard de Performance Comercial

Projeto de portfólio com fluxo completo de dados: ingestão → limpeza → banco relacional → consultas analíticas → visualização em Power BI.

---

## 🎯 Contexto e Objetivo

O dataset público da Olist contém informações reais de um e-commerce brasileiro com mais de 100 mil pedidos entre 2016 e 2018. O objetivo deste projeto é simular o trabalho de um Analista de BI: transformar dados brutos em um painel interativo que responda perguntas estratégicas de negócio.

**Perguntas respondidas:**
- Qual é a receita mensal e a tendência de crescimento?
- Quais estados concentram mais atrasos nas entregas?
- Como está a satisfação dos clientes (NPS)?
- Quais categorias de produto geram mais receita?
- Qual é o tempo médio de entrega por região?

---

## 🛠️ Tecnologias Utilizadas

| Etapa | Ferramenta |
|-------|-----------|
| Limpeza e transformação | Python (Pandas) |
| Banco de dados relacional | SQLite |
| Consultas analíticas | SQL |
| Visualização | Power BI |
| Versionamento | Git + GitHub |

---

## 📁 Estrutura do Repositório

```
olist-bi-dashboard/
├── data/
│   ├── raw/                  ← arquivos originais do Kaggle (não versionados)
│   └── processed/            ← tabelas limpas exportadas para o Power BI
├── notebooks/
│   └── olist_etl_sql_analysis.ipynb   ← ETL completo + consultas SQL
├── dashboard/
│   └── olist_dashboard.pbix  ← arquivo Power BI
├── .gitignore
└── README.md
```

---

## ▶️ Como Executar

**1. Clone o repositório**
```bash
git clone https://github.com/Camilarmota/olist-bi-dashboard.git
cd olist-bi-dashboard
```

**2. Instale as dependências**
```bash
pip install pandas sqlite3 jupyter
```

**3. Baixe o dataset**

Acesse o Kaggle e baixe o [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).  
Extraia todos os CSVs na pasta `data/raw/`.

**4. Execute o notebook**
```bash
jupyter notebook notebooks/olist_etl_sql_analysis.ipynb
```
Rode todas as células em ordem. Os arquivos processados serão gerados automaticamente em `data/processed/`.

**5. Abra o dashboard**

No Power BI Desktop, abra `dashboard/olist_dashboard.pbix`.  
Se necessário, atualize o caminho dos arquivos em *Transformar Dados → Configurações da Fonte*.

---

## 📊 Páginas do Dashboard

**Página 1 — Visão Geral Executiva**
KPIs de receita, pedidos, nota média e % entregas no prazo. Evolução mensal de receita e mapa de pedidos por estado.

**Página 2 — Logística & Entregas**
Tempo médio de entrega por estado, ranking de atrasos por região e comparativo entre prazo estimado e prazo real.

**Página 3 — Satisfação do Cliente**
Distribuição de notas, NPS Score, nota média por categoria e correlação entre atraso e avaliação.

---

## 💡 Principais Insights

> *Valores reais serão preenchidos após execução completa do notebook.*

- 📈 **Receita:** pico de vendas identificado em novembro (Black Friday)
- 🚚 **Logística:** estados do Norte e Nordeste concentram as maiores taxas de atraso
- ⭐ **NPS:** correlação negativa entre atraso na entrega e nota do cliente — pedidos atrasados têm nota média X pontos abaixo
- 🛍️ **Categorias:** as 3 categorias mais rentáveis representam X% da receita total

---

## 📐 Modelagem de Dados (Power BI)

O modelo segue o esquema estrela com `orders` como tabela fato central:

```
orders (fato)
  ├── customers      (dimensão — localização)
  ├── order_items    (fato complementar — valores e produtos)
  │     └── products (dimensão — categoria)
  ├── order_reviews  (dimensão — avaliações)
  └── sellers        (dimensão — vendedores)
```

---

## 🧮 Medidas DAX Criadas

```dax
-- NPS Score
NPS Score =
VAR promotores = COUNTROWS(FILTER(order_reviews, order_reviews[review_score] >= 4))
VAR detratores = COUNTROWS(FILTER(order_reviews, order_reviews[review_score] <= 2))
VAR total      = COUNTROWS(order_reviews)
RETURN DIVIDE(promotores - detratores, total) * 100

-- Taxa de Atraso
Taxa de Atraso % =
DIVIDE(
    COUNTROWS(FILTER(orders, orders[entrega_atrasada] = 1)),
    COUNTROWS(orders)
) * 100

-- Ticket Médio
Ticket Médio =
DIVIDE(SUM(order_items[valor_total]), DISTINCTCOUNT(order_items[order_id]))
```

---

## 👩‍💻 Sobre a Autora

**Camila Rodrigues Mota**  
Analista de Dados & BI Júnior | Salvador, BA

Profissional em transição de carreira da área da saúde para Dados e BI, com experiência em Python, SQL e Power BI.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Camila%20Mota-0077B5?style=flat&logo=linkedin)](https://linkedin.com/in/camila-rodrigues-mota/)
[![GitHub](https://img.shields.io/badge/GitHub-Camilarmota-181717?style=flat&logo=github)](https://github.com/Camilarmota)

---

*Dataset público disponibilizado pela [Olist](https://olist.com) via Kaggle sob licença CC BY-NC-SA 4.0.*
