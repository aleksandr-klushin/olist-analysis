SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT review_id) AS uniq_review_id,
       COUNT(DISTINCT (review_id, order_id)) AS uniq_pairs
FROM order_reviews;