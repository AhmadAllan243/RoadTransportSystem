#include <iostream>
#include <stdlib.h>
#include <cstring>
#include <cppconn/driver.h>
#include <cppconn/exception.h>
#include <cppconn/resultset.h>
#include <cppconn/statement.h>

using namespace std;

int main() {
	try {
		sql::Driver* driver;
		sql::Connection* con;
		sql::Statement* stmt;
		sql::ResultSet* res;

		cout << "Enter your area: ";
		string area, query;
		getline(cin, area);
		query = "SELECT DISTINCT r.Route_ID, r.Route_Name, r.Start_Terminal AS startTerminal, r.End_Terminal AS endTerminal "
			"FROM ROUTE r "
			"JOIN ROUTE_STOP rs1 ON r.Route_ID = rs1.Route_ID "
			"JOIN ALL_STOPS s1 ON rs1.Stop_ID = s1.Stop_ID "
			"JOIN ROUTE_STOP rs2 ON r.Route_ID = rs2.Route_ID "
			"JOIN ALL_STOPS s2 ON rs2.Stop_ID = s2.Stop_ID "
			"WHERE(rs1.stop_Name LIKE '%" + area + "%' OR rs2.stop_Name LIKE '%" + area + "%') "
			"ORDER BY r.Route_ID;";

		driver = get_driver_instance();
		con = driver->connect("tcp://127.0.0.1:3306", "root", "tea12983476");
		con->setSchema("rta");

		stmt = con->createStatement();
		res = stmt->executeQuery(query);
		cout << "\t MySQL Responses"<<endl;
		while (res->next()) {
			cout << res->getString("Route_ID") + " " + res->getString("Route_Name") + " " + 
				res->getString("startTerminal") + " " + res->getString("endTerminal") << endl;
		}
		delete res;
		delete stmt;
		delete con;
	}

	catch (sql::SQLException& e) {
		cout << "#ERR:SQLException in " << __FILE__;
		cout << "#ERR: " << e.what();
		cout << "(MySQL error code: " << e.getErrorCode();
		cout << ",SQLState: " << e.getSQLState() << ")" << endl;

	}
	cout << endl;

	return 0;
}
