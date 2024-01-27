package db

import (
	"context"
	"database/sql" // Import the sql package to use sql.NullString
	"testing"

	"github.com/Duwal94/api.git/db/util"
	"github.com/stretchr/testify/require"
)

func TestCreateRole(t *testing.T) {
	arg := CreateRoleParams{
		RoleName:  sql.NullString{String: util.RandomString(5), Valid: true},
		UpdatedBy: sql.NullString{String: "riyesh", Valid: true},
		CreatedBy: sql.NullString{String: "riyesh", Valid: true},
	}
	role, err := testQueries.CreateRole(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, role)

	require.Equal(t, arg.RoleName, role.RoleName)
	require.Equal(t, arg.UpdatedBy, role.UpdatedBy)

	require.NotZero(t, role.ID)
	require.NotZero(t, role.CreatedAt)
	require.NotZero(t, role.UpdatedAt)
	require.NotZero(t, role.CreatedBy)
}
