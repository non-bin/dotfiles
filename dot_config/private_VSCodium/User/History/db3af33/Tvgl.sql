-- Active: 1732947959990@@127.0.0.1@3306
SELECT e.artist_id AS artist_id, e.event_type AS event_type, e.created_at AS timestamp FROM user_events e LIMIT 100
