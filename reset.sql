/**
 * SQL script to reset the database by dropping all tables.
 */

DROP TABLE IF EXISTS resource_access_log CASCADE;
DROP TABLE IF EXISTS intervention CASCADE;
DROP TABLE IF EXISTS cyberbullying_case CASCADE;
DROP TABLE IF EXISTS case_state_history CASCADE;
DROP TABLE IF EXISTS case_state CASCADE;
DROP TABLE IF EXISTS interaction CASCADE;
DROP TABLE IF EXISTS interaction_types CASCADE;
DROP TABLE IF EXISTS psychologist_info CASCADE;
DROP TABLE IF EXISTS moderator_info CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS roles CASCADE;
DROP TABLE IF EXISTS resources CASCADE;