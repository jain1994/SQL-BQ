

select * from `bucket_demo.bucket_partitioned` where date = '2021-10-30';


create table `bucket_demo.bucket_123`
partition by date cluster by id as select * from bucket_demo.gcs_table;


select * from `bucket_demo.bucket_123` where date = '2021-10-30' and id = 2;