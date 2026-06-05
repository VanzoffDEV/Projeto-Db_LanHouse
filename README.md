# Sistema de Gestão de Banco de Dados - Lan House 🎮

Projeto acadêmico desenvolvido na disciplina de Programação e Otimização de Banco de Dados, focado na modelagem, normalização e implementação de um sistema relacional completo para uma Lan House.

---

## 🚀 Progresso do Desenvolvimento

### 🛠️ Semana 1: Modelagem, Normalização e Fundação do Projeto
Nesta primeira etapa, o foco foi transformar as regras de negócio de uma Lan House física em uma arquitetura de banco de dados relacional íntegra e performática.
* **Modelagem Conceitual e Lógica:** Elaboração dos diagramas MER e DER, mapeando com precisão as cardinalidades (1:N e N:N) entre clientes, computadores, produtos, consumos, torneios e inscrições.
* **Processo de Normalização:** Aplicação rigorosa da 1ª, 2ª e 3ª Formas Normais (FN) para eliminar anomalias de atualização, redundâncias de dados e garantir a atomicidade de cada célula.
* **Estrutura DDL (`SCHEMA.SQL`):** Criação das tabelas utilizando restrições de integridade fundamentais (`PRIMARY KEY`, `FOREIGN KEY` com ações de `RESTRICT`/`CASCADE`, `UNIQUE` e `AUTO_INCREMENT`).
* **Carga Inicial DML (`DATA.SQL`):** População do banco de dados contendo exatamente **15 registros realistas por tabela**, estabelecendo uma base sólida para testes de volume de dados.

### 📊 Semana 2: Consultas Avançadas e Relatórios Estratégicos
A segunda fase teve como objetivo extrair inteligência de negócio a partir dos dados persistidos, aplicando agrupamentos e junções avançadas.
* **Refatoração Prática:** Inserção de cenários específicos de teste (como clientes cadastrados sem histórico de uso e clientes com múltiplas sessões sequenciais) para validar as regras dos relatórios.
* **Relatório 1 - Ranking de Faturamento (`RELATORIOS.SQL`):** Implementação de uma consulta analítica complexa combinando múltiplos `JOINs`, funções de agregação (`COUNT` e `SUM`) e agrupamentos por ID. Utilização da cláusula `HAVING` para filtrar apenas clientes com alta recorrência (> 1 sessão), limitando o resultado ao Top 5 de faturamento histórico.
* **Relatório 2 - Clientes sem Sessão (`RELATORIOS.SQL`):** Criação de uma listagem focada em marketing para identificar clientes inativos. Foi aplicado o padrão de otimização `LEFT JOIN` combinado com a checagem `IS NULL` na chave estrangeira, garantindo uma consulta rápida e segura para rastrear registros órfãos.

---

## 🗂️ Estrutura do Repositório

* **`SCHEMA.SQL`**: Scripts DDL para criação do banco de dados `LanHouse_DB` e estruturação de todas as tabelas.
* **`DATA.SQL`**: Scripts DML contendo as inserções da carga inicial e dados de teste.
* **`RELATORIOS.SQL`**: Scripts DQL contendo as consultas estruturadas dos relatórios estratégicos.
* **`MODELO_CONCEITUAL.pdf`**: Diagrama Entidade-Relacionamento (DER) abstrato das regras de negócio.
* **`MODELO_LOGICO.pdf`**: Diagrama relacional detalhando chaves primárias, estrangeiras e tipos de dados.

## 🛠️ Tecnologias Utilizadas
* MySQL / MySQL Shell
* Engenharia de Dados e Modelagem Relacional


## 👤 Autores
* **Abelardo Vanzoff**
* **João Pedro**
* **Leticia de Carvalho**
m
