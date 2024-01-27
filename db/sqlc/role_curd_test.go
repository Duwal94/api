package db

import (
	"context"
	"database/sql" // Import the sql package to use sql.NullString
	"testing"
	"time"

	"github.com/Duwal94/api.git/db/util"
	"github.com/stretchr/testify/require"
)

func createRandomrole(t *testing.T) Roles {
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

	return role
}

func TestCreateRole(t *testing.T) {
	_ = createRandomrole(t)
}

func TestGetRole(t *testing.T) {
	role1 := createRandomrole(t)
	role2, err := testQueries.GetRole(context.Background(), role1.ID)

	require.NoError(t, err)
	require.NotEmpty(t, role2)

	require.Equal(t, role1.ID, role2.ID)
	require.Equal(t, role1.RoleName, role2.RoleName)
	require.Equal(t, role1.UpdatedBy, role2.UpdatedBy)
}

func TestUpdateRole(t *testing.T) {
	role1 := createRandomrole(t)

	arg := UpdateRoleParams{
		ID:        role1.ID,
		RoleName:  sql.NullString{String: util.RandomString(5), Valid: true},
		UpdatedBy: sql.NullString{String: util.RandomString(5), Valid: true},
	}

	err := testQueries.UpdateRole(context.Background(), arg)
	require.NoError(t, err)

	// Verify that the role has been updated
	updatedRole, err := testQueries.GetRole(context.Background(), role1.ID)
	require.NoError(t, err)

	// Check updated fields
	require.Equal(t, arg.RoleName, updatedRole.RoleName)
	require.Equal(t, arg.UpdatedBy, updatedRole.UpdatedBy)
	require.Equal(t, role1.ID, updatedRole.ID)
	require.WithinDuration(t, role1.UpdatedAt, updatedRole.UpdatedAt, time.Second)
	require.Equal(t, role1.CreatedBy, updatedRole.CreatedBy)
}

func TestDeleteRole(t *testing.T) {
	role := createRandomrole(t)

	err := testQueries.DeleteRole(context.Background(), role.ID)
	require.NoError(t, err)

	// Verify that the role has been deleted
	_, err = testQueries.GetRole(context.Background(), role.ID)
	require.Error(t, err) // Expecting an error since the role should not exist
}

