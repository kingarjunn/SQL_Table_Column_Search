--
SELECT 
  TB.TableName
  ,SC.Name
FROM
  SYS.COLUMNS SC
  JOIN (
        SELECT Table_CATALOG +'.'+Table_SCHEMA+'.'+Table_name as TableName,
        OBJECT_ID(Table_CATALOG +'.'+Table_SCHEMA+'.'+Table_name) as TableObjectID
        FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'
        AND table_schema = 'dbo'
  ) AS TB on TB.TableObjectID = SC.OBJECT_ID
