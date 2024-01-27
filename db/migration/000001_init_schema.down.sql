-- Drop tables with foreign key references
DROP TABLE IF EXISTS "role_policy";
DROP TABLE IF EXISTS "policy_permission";
DROP TABLE IF EXISTS "permission";

-- Drop tables without foreign key references
DROP TABLE IF EXISTS "roles";
DROP TABLE IF EXISTS "operation";
DROP TABLE IF EXISTS "resource";
DROP TABLE IF EXISTS "policy";
