CREATE TABLE "roles" (
  "id" bigserial PRIMARY KEY,
  "role_name" varchar,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "created_by" varchar,
  "updated_by" varchar,
  "updated_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "operation" (
  "id" bigserial PRIMARY KEY,
  "name" varchar,
  "created_by" varchar,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_by" varchar,
  "description" varchar
);

CREATE TABLE "resource" (
  "id" bigserial PRIMARY KEY,
  "name" varchar,
  "created_by" varchar,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_by" varchar
);

CREATE TABLE "policy" (
  "id" bigserial PRIMARY KEY,
  "name" varchar,
  "created_by" varchar,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_by" varchar,
  "description" varchar,
  "is_active" smallint,
  "functionality" varchar,
  "is_public" smallint
);

CREATE TABLE "permission" (
  "id" integer PRIMARY KEY,
  "name" varchar,
  "created_by" varchar,
  "created_at" timestamp,
  "updated_at" timestamp,
  "updated_by" varchar,
  "description" varchar,
  "is_active" smallint,
  "operation_id" integer,
  "resource_id" integer
);

CREATE TABLE "policy_permission" (
  "id" integer PRIMARY KEY,
  "permission_id" integer,
  "policiy_id" integer,
  "created_at" timestamp,
  "created_by" varchar,
  "updated_at" timestamp,
  "updated_by" varchar,
  "is_active" smallint
);

CREATE TABLE "role_policy" (
  "id" integer PRIMARY KEY,
  "policiy_id" integer,
  "role_id" integer,
  "created_at" timestamp,
  "created_by" varchar,
  "updated_at" timestamp,
  "updated_by" varchar,
  "is_active" smallint
);

ALTER TABLE "policy_permission" ADD FOREIGN KEY ("policiy_id") REFERENCES "policy" ("id");

ALTER TABLE "policy_permission" ADD FOREIGN KEY ("permission_id") REFERENCES "permission" ("id");

ALTER TABLE "role_policy" ADD FOREIGN KEY ("policiy_id") REFERENCES "policy" ("id");

ALTER TABLE "role_policy" ADD FOREIGN KEY ("role_id") REFERENCES "roles" ("id");

ALTER TABLE "permission" ADD FOREIGN KEY ("operation_id") REFERENCES "operation" ("id");

ALTER TABLE "permission" ADD FOREIGN KEY ("resource_id") REFERENCES "resource" ("id");
