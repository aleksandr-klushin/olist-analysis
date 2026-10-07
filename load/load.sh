#!/bin/bash
set -e
cd "$(dirname "$0")/.."
run() { docker compose exec -T db psql -U olist -c "$1"; }

docker compose exec -T db psql -U olist < sql/load.sql
run "\copy customers FROM '/data/olist_customers_dataset.csv' WITH (FORMAT csv, HEADER true)"
run "\copy orders FROM '/data/olist_orders_dataset.csv' WITH (FORMAT csv, HEADER true)"
run "\copy products FROM '/data/olist_products_dataset.csv' WITH (FORMAT csv, HEADER true)"
run "\copy sellers FROM '/data/olist_sellers_dataset.csv' WITH (FORMAT csv, HEADER true)"
run "\copy product_category_name_translation FROM '/data/product_category_name_translation.csv' WITH (FORMAT csv, HEADER true)"
run "\copy order_items FROM '/data/olist_order_items_dataset.csv' WITH (FORMAT csv, HEADER true)"
run "\copy order_payments FROM '/data/olist_order_payments_dataset.csv' WITH (FORMAT csv, HEADER true)"
run "\copy order_reviews FROM '/data/olist_order_reviews_dataset.csv' WITH (FORMAT csv, HEADER true)"
