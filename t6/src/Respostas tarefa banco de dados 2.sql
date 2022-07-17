--1 - municipios que não pertencem a regiao norte

SELECT NomeMunicipio FROM Municipio M
JOIN ESTADO E
ON M.CodEstado = E.CodEstado
JOIN Regiao R
ON R.CodRegiao = E.CodRegiao
WHERE NomeRegiao != 'Norte'

--2 - municipios que possuem nome

SELECT * FROM Municipio
where NomeMunicipio != ''

--3 - media de municipios por regiao

---- Quantidade de municipios por região

SELECT count(*) FROM Municipio as M
JOIN ESTADO as E
ON M.CodEstado = E.CodEstado
JOIN Regiao as R
ON R.CodRegiao = E.CodRegiao
GROUP BY R.CodRegiao
----
-- Resposta
SELECT count(*)/5 FROM Municipio

--4 - sigla dos estados com as respectivas quantidades de municipios

SELECT  E.SiglaEstado, count(M.CodMunicipio) as quantidade_municipios  FROM Municipio as M
JOIN ESTADO as E
ON M.CodEstado = E.CodEstado
JOIN Regiao as R
ON R.CodRegiao = E.CodRegiao
GROUP BY E.SiglaEstado

--5 - municipio com as pessoas mais idosas

SELECT  TOP 1 M.NomeMunicipio, MAX(I.IDH_LONGEVIDADE) AS MÁXIMA FROM Indice AS I
JOIN Municipio AS M
ON M.CodMunicipio = I.CodMunicipio
GROUP BY M.NomeMunicipio
ORDER BY MÁXIMA DESC

--6 - ano em que salvador obteve o melhor indice de instrução

SELECT M.NomeMunicipio, MAX(I.ANO) AS MÁXIMA FROM INDICE AS I
JOIN Municipio AS M
ON I.CODMUNICIPIO = M.CODMUNICIPIO
WHERE M.NomeMunicipio = 'SALVADOR'
GROUP BY M.NomeMunicipio

--7 - qual o municipio com a melhor distribuição de renda

SELECT TOP 1 M.NomeMunicipio, MAX(I.IDH_Renda) AS MÁXIMA FROM INDICE AS I
JOIN Municipio AS M
ON I.CODMUNICIPIO = M.CODMUNICIPIO
GROUP BY M.NomeMunicipio
ORDER BY MÁXIMA DESC

--8 - quais estados possuem municipios com IDH geral maior que 0.8

SELECT E.NomeEstado, I.IDH_Geral from Estado as E
JOIN Municipio AS M
ON M.CodEstado = E.CodEstado
JOIN Indice AS I
ON M.CodMunicipio = I.CodMunicipio
WHERE I.IDH_Geral > 0.8

--9 - qual o maior IDH de educação por estado

SELECT E.NomeEstado, MAX(I.IDH_Educacao) AS MÁXIMA from Estado as E
JOIN Municipio AS M
ON M.CodEstado = E.CodEstado
JOIN Indice AS I
ON M.CodMunicipio = I.CodMunicipio
GROUP BY E.NomeEstado

--10 - relatorio de todos IDHs da bahia de 91 a 2000, inclusive com a difereça entre os mesmos

SELECT E.NomeEstado,I.Ano, I.IDH_Educacao, I.IDH_Geral, I.IDH_Longevidade, I.IDH_Renda from Estado as E
JOIN Municipio AS M
ON M.CodEstado = E.CodEstado
JOIN Indice AS I
ON M.CodMunicipio = I.CodMunicipio
where E.NomeEstado = 'BAHIA' AND I.ANO BETWEEN 1991 AND 2000
ORDER BY I.Ano

--11 - relatorio comparativo entre as medias dos IDHs de SC e AL de 2000 e 91

SELECT E.SiglaEstado, SUM(IDH_Educacao+IDH_Geral+IDH_Longevidade+IDH_Renda/4)/COUNT(E.SiglaEstado) AS MEDIA_1991  FROM INDICE AS I
JOIN Municipio M
ON M.CodMunicipio = I.CodMunicipio
JOIN Estado E
ON E.CodEstado = M.CodEstado
WHERE E.SiglaEstado = 'SC' OR E.SiglaEstado = 'AL' AND I.Ano = 1991 
GROUP BY E.SiglaEstado

-- 12 e 3 esboço

UNION 

SELECT E.SiglaEstado,  SUM(IDH_Educacao+IDH_Geral+IDH_Longevidade+IDH_Renda/4)/COUNT(E.SiglaEstado) AS MEDIA_2000 FROM INDICE AS I
JOIN Municipio M
ON M.CodMunicipio = I.CodMunicipio
JOIN Estado E
ON E.CodEstado = M.CodEstado
WHERE E.SiglaEstado = 'SC' OR E.SiglaEstado = 'AL' AND I.Ano = 2000 
GROUP BY E.SiglaEstado

select * from Estado
select * from Regiao
select * from Municipio
select * from Indice

select E.SiglaEstado, count(M.codmunicipio) from Estado as E
join Municipio as M 
on E.CodEstado = M.CodEstado
group by M.CodMunicipio