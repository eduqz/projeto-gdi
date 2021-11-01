# Projeto Lógico

Participante(<span style="text-decoration:underline;">CPF</span>, Nome, Nascimento)

Empresa(<span style="text-decoration:underline;">CNPJ</span>, Nome, Fundação)

Setor(<span style="text-decoration:underline;">CNPJ, setor</span>) (atributo multivalorado de Empresa)

	CNPJ -> Empresa(CNPJ)

Ação(<span style="text-decoration:underline;">CNPJ</span>, <span style="text-decoration:underline;">Código</span>, Preço!, CPF) (Entidade fraca da relação empresa ação) 

	CNPJ -> Empresa(CNPJ)

	CPF -> Dono(CPF)

---

## Mapeamento da Herança

Ordinária(<span style="text-decoration:underline;">CNPJ</span>)

	CNPJ -> Empresa(CNPJ)

Preferencial(<span style="text-decoration:underline;">CNPJ</span>, Classe)

	CNPJ -> Empresa(CNPJ)

---

Bolsa_de_valores(<span style="text-decoration:underline;">Código_Bolsa</span>, País, Fundação)

Comprador(<span style="text-decoration:underline;">CPF</span>,Nome,Nascimento)

Dono(<span style="text-decoration:underline;">CPF</span>, Nome, Nascimento, end_Rua, end_Bairro, end_Cidade)

---

## Relações

Controle(<span style="text-decoration:underline;">Recebe</span>, <span style="text-decoration:underline;">Exerce</span>)

	Recebe -> Empresa(CNPJ)

	Exerce -> Empresa(CNPJ)

Tem(<span style="text-decoration:underline;">CPF</span>, <span style="text-decoration:underline;">CNPJ</span>, Cargo, Tipo) 

	CPF -> Participante(CPF)

	CNPJ -> Empresa(CNPJ)

Negocia(<span style="text-decoration:underline;">Código</span>, <span style="text-decoration:underline;">CPF</span>, <span style="text-decoration:underline;">CNPJ, Código_Ação</span>, <span style="text-decoration:underline;">Instante, </span>Taxa_de_negociação)

	Código -> Bolsa_de_valores(Código_Bolsa) 

	CPF -> Comprador(CPF)

	(CNPJ,Código_Ação<span style="text-decoration:underline;">)</span> -> Ação(CNPJ,Código)
