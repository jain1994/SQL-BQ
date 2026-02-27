select * from `ha-demo-486408.bucket_demo.gcs_table`;

-- CREATE OR REPLACE EXTERNAL TABLE `ha-demo-486408.bucket_demo.customers_ext`
-- OPTIONS (
--   format = 'CSV',
--   uris = ['gs://demo-bk/my-folder/sample_customers.csv'],
--   skip_leading_rows = 1,
--   autodetect = TRUE
-- );

CREATE OR REPLACE EXTERNAL TABLE `ha-demo-486408.bucket_demo.customers_ext`
(
  id INT64,
  name STRING,
  city STRING,
  spend FLOAT64
)
OPTIONS (
  format = 'CSV',
  uris = ['gs://demo-bk/my-folder/sample_customers.csv'],
  skip_leading_rows = 1
);

select * from `ha-demo-486408.bucket_demo.customers_ext`
