/****** Azure Synapse - Read Parquet ******/
CREATE view [dbo].[aws_ec2_instances] as
SELECT 
	REPLACE([_cq_sync_time], '"', '') AS [_cq_sync_time]
	,REPLACE([_cq_source_name], '"', '') AS [_cq_source_name]
	,REPLACE([_cq_id], '"', '') AS [_cq_id]
	,REPLACE([_cq_parent_id], '"', '') AS [_cq_parent_id]
	,REPLACE([account_id], '"', '') AS [account_id]
	,REPLACE([region], '"', '') AS [region]
	,REPLACE([arn], '"', '') AS [arn]
	,REPLACE(LEFT(RIGHT([tags], LEN([tags]) - 1), LEN([tags])-2), '\"', '"') AS [tags]
	,REPLACE([instance_id], '"', '') AS [instance_id]
	,REPLACE([instance_type], '"', '') AS [instance_type]
	,REPLACE(LEFT(RIGHT([network_interfaces], LEN([network_interfaces]) - 1), LEN([network_interfaces])-2), '\"', '"') AS [network_interfaces]
	,REPLACE([private_ip_address], '"', '') AS [private_ip_address]
	,REPLACE([public_dns_name], '"', '') AS [public_dns_name]
	,REPLACE([public_ip_address], '"', '') AS [public_ip_address]
	,REPLACE([vpc_id], '"', '') AS [vpc_id]
FROM
    OPENROWSET(
        BULK 'https://prodstorage.blob.core.windows.net/sync/*/aws/aws_ec2_instances*', 
        FORMAT = 'PARQUET'
) 
WITH (
	[_cq_sync_time] VARCHAR(8000)
	,[_cq_source_name] VARCHAR(8000)
	,[_cq_id] VARCHAR(8000)
	,[_cq_parent_id] VARCHAR(8000)
	,[account_id] VARCHAR(8000)
	,[region] VARCHAR(8000)
	,[arn] VARCHAR(8000)
	,[tags] VARCHAR(8000)
	,[instance_id] VARCHAR(8000)
	,[instance_type] VARCHAR(8000)
	,[network_interfaces] VARCHAR(MAX)
	,[private_ip_address] VARCHAR(8000)
	,[public_dns_name] VARCHAR(8000)
	,[public_ip_address] VARCHAR(8000)
	,[vpc_id] VARCHAR(8000)
) as fct
where CAST(fct.filepath(1) AS DATE) =
	(SELECT
	   max(CAST(fct.filepath(1) AS DATE))
	FROM
		OPENROWSET(
			BULK 'https://prodstorage.blob.core.windows.net/sync/*/aws/aws_ec2_instances*',
			FORMAT = 'PARQUET'
	) as fct)
