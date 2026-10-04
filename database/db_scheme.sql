CREATE TABLE "follows" (
  "following_user_id" integer NOT NULL,
  "followed_user_id" integer NOT NULL,
  "created_at" timestamp
);

CREATE TABLE "users" (
  "id" integer PRIMARY KEY,
  "username" varchar,
  "created_at" timestamp
);

CREATE TABLE "posts" (
  "id" integer PRIMARY KEY,
  "user_id" integer NOT NULL,
  "place_id" integer NOT NULL,
  "title" varchar,
  "text" text,
  "created_at" timestamp
);

CREATE TABLE "raiting" (
  "id" integer PRIMARY KEY,
  "user_id" integer NOT NULL,
  "post_id" integer NOT NULL
);

CREATE TABLE "image" (
  "id" integer PRIMARY KEY,
  "post_id" integer NOT NULL,
  "id_s3" varchar
);

CREATE TABLE "place" (
  "id" integer PRIMARY KEY,
  "geo_position" varchar
);

CREATE TABLE "comment" (
  "id" integer PRIMARY KEY,
  "post_id" integer NOT NULL,
  "user_id" integer NOT NULL,
  "text" text,
  "created_at" timestamp
);

COMMENT ON COLUMN "posts"."text" IS 'Content of the post';

COMMENT ON COLUMN "comment"."text" IS 'Comment of the post';

ALTER TABLE "posts" ADD CONSTRAINT "user_posts" FOREIGN KEY ("user_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "follows" ADD FOREIGN KEY ("following_user_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "follows" ADD FOREIGN KEY ("followed_user_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "raiting" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "raiting" ADD FOREIGN KEY ("post_id") REFERENCES "posts" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "image" ADD FOREIGN KEY ("post_id") REFERENCES "posts" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "posts" ADD FOREIGN KEY ("place_id") REFERENCES "place" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "comment" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "comment" ADD FOREIGN KEY ("post_id") REFERENCES "posts" ("id") DEFERRABLE INITIALLY IMMEDIATE;

-- Defer constraint checking for INSERT
BEGIN;
SET CONSTRAINTS ALL DEFERRED;

INSERT INTO "users" ("id", "username")
VALUES
  (0, 'Alice'),
  (1, 'Bob'),
  (2, 'Candice'),
  (3, 'David');
INSERT INTO "follows" ("following_user_id", "followed_user_id", "created_at")
VALUES
  (1, 0, '2026-01-01'),
  (3, 2, '2026-02-28');
INSERT INTO "posts" ("id", "title", "user_id")
VALUES
  (0, 'Welcome to the forum!', 0),
  (1, 'Guidelines', 1),
  (2, 'Hello all!', 3);

SET CONSTRAINTS ALL IMMEDIATE;
COMMIT;