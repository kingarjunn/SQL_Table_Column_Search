use databasename; --give your database name.
-------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------
--drop table #Tables
--drop table #columns
-------------------------------------------------------------------------------------------------------------------------------------------------------------
IF OBJECT_ID('tempdb..#Tables') IS NOT NULL DROP TABLE #Tables
IF OBJECT_ID('tempdb..#columns') IS NOT NULL DROP TABLE #columns
-------------------------------------------------------------------------------------------------------------------------------------------------------------
begin
	with data as(
		SELECT Table_CATALOG +'.'+Table_SCHEMA+'.'+Table_name as tablename, 
		Row_Number() over (order by Table_name ) as rownum
		FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'
		AND table_schema = 'dbo'
	)
	select * 
	into #Tables
	from data
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------

create table #columns(tablename varchar(300) null, columnname varchar(300) null)
declare @cnt int = (select max(rownum) from #Tables)
declare @i int=1
begin
while @i <=@cnt
	begin
	declare @tempstr varchar(max) = (select top 1 tablename from #Tables where rownum = @i)
	declare @query varchar(max) = 'SELECT '''+@tempstr +''' ,name FROM sys.columns WHERE object_id = OBJECT_ID('''+@tempstr+''')' 
	set @i = @i+1
	--print @query
	begin
		insert into #columns
		exec(@query)
	end
	end
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------


--change below feilds to find the what you are looking for 
--or query with your own logic.
--select * from #columns where columnname like '%contractsection%'
select * from #columns where tablename like '%contractsection%' and columnname like '%rever%'


--
