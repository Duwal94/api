-- name: CreateRole :one
INSERT INTO roles (role_name,  created_by, updated_by )
VALUES ($1, $2, $3)
RETURNING *;

-- name: GetRole :one
SELECT * FROM roles WHERE id = $1;

-- name: UpdateRole :exec
UPDATE roles
SET role_name = $1, updated_by = $2
WHERE id = $3;

-- name: DeleteRole :exec
DELETE FROM roles WHERE id = $1;