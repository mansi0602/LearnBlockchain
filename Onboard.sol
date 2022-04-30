            // SPDX-License-Identifier: GPL-3.0
            pragma solidity >=0.7.0 <0.9.0;

            contract Onboard{

                uint public empId =1;
                struct Employee{
                    address wallet;
                    uint id;
                    string firstName;
                    string lastName;
                    uint doj;
                    uint houseNumber;
                    string street;
                    string city; 
                    string state;
                    string country;
                    uint pincode;
                    bool isActive;
                }

            
                mapping(uint => Employee) public emp;
                mapping(address => uint) empUnique;
                Employee[] public employees;

                error EmployeeNotFound(uint id);

                
                function createEmployee(string memory _firstName,
                string memory _lastName, uint _doj, uint _houseNumber, string memory _street, 
                string memory _city, string memory _state, string memory _country, uint _pincode) public returns(uint){
                require(bytes(_firstName).length > 0, "First name in required");
                require(bytes(_lastName).length > 0, "Last name in required");
                uint _id = empId++;
                    Employee memory employee = Employee({
                        wallet: msg.sender,
                        id: _id,
                        firstName: _firstName,
                        
                        lastName: _lastName,
                        doj: _doj,
                        houseNumber: _houseNumber,
                        street: _street,
                        city: _city,
                        state: _state,
                        country: _country,
                        pincode: _pincode,
                        isActive: true
                    });
                    empUnique[msg.sender] = _id;
                    emp[_id]=employee;
                    employees.push(employee);
                    return _id;

                }

                function editEmployeeDetails(uint _id, string memory _firstName,
                string memory _lastName,  uint _houseNumber, string memory _street, 
                string memory _city, string memory _state, string memory _country, uint _pincode) public returns(uint){
                
                Employee memory empEdit = emp[_id];
                if(empEdit.wallet == address(0)){
                        revert EmployeeNotFound(_id);
                }
                require(msg.sender == empEdit.wallet,"Only self employee can edit details");
                require(bytes(_firstName).length > 0, "First name in required");
                require(bytes(_lastName).length > 0, "Last name in required");
                
                empEdit.firstName = _firstName;
                empEdit.lastName = _lastName;
                empEdit.houseNumber = _houseNumber;
                empEdit.street = _street;
                empEdit.city = _city;
                empEdit.state = _state;
                empEdit.country = _country;
                empEdit.pincode = _pincode;
                
                    emp[_id]=empEdit;
                    return _id;

                }

                function deleteEmployee(uint _id) public returns(uint){
                
                    if(emp[_id].wallet == address(0)){
                        revert EmployeeNotFound(_id);
                }
                    Employee memory softDel = emp[_id];
                    softDel.isActive = false;
                    emp[_id] = softDel;
                    return _id;

                }

            
                function getEmployeeList() public view  returns(Employee[] memory){
                    return employees;
                }

                function getEmployeeById(uint _id) public view  returns(Employee memory){
                    
                    if(emp[_id].id != _id){
                        revert EmployeeNotFound(_id);
                    }
                    return emp[_id];
                }

            }
