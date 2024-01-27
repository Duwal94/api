func TestMain(m *testing.M){
	conn, err :=sql.Open(dbDriver,dbSource)
	if err != nil{
		log.Fatal("cannot connect to db:",err)
	}
	testQueries	= New(conn)

	os.Exit(m.Run())
}