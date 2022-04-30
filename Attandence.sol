// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Attandence{

    struct Employee{
        address wallet;
        uint id;
        string name;
        uint date;
        bool isPresent;
    }

    Employee[] public employees;
    mapping(address => uint) uniqueId;
    mapping(uint => Employee) employee;
    error NotUniqueEmployeeAndAddress(address wallet, uint id);
    error EmployeeRecordedAttendance(uint id, string name);
    
    
    function insertUser(uint  _id, string memory _empName, uint  _todaysdate, bool  _isPresent) public{
        for(uint i =0; i< employees.length; i++){
            if(employees[i].wallet == msg.sender){
                revert NotUniqueEmployeeAndAddress(msg.sender, _id);
            }

            if(employees[i].id == _id){
                revert EmployeeRecordedAttendance(_id, _empName);
            }
        }
        Employee memory emp = Employee({
            wallet: msg.sender,
            id: _id,
            name: _empName,
            date: _todaysdate,
            isPresent: _isPresent
        });
        employees.push(emp);
    }

    function getPresentEmployees() public view returns(Employee[] memory){
        return employees;
    }
}
