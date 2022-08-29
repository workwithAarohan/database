-- PL/SQL objects

SET SERVEROUTPUT ON;

DROP TYPE customer;

DROP TYPE address;

/
CREATE OR REPLACE TYPE ADDRESS AS OBJECT
(
    house_no varchar2(10),
    street varchar2(30),
    city varchar2(20),
    state varchar2(10),
    pincode varchar2(10)
);

/

CREATE OR REPLACE TYPE customer AS OBJECT
(
    code number(5),
    name varchar2(30),
    contact_no varchar2(12),
    addr address,
    member procedure display
);

/

DECLARE 
    residence address;
BEGIN
    residence := address('103A', 'Imadol', 'Lalitpur', 'Bagmati', '103123');
    dbms_output.put_line('House No: ' || residence.house_no);
    dbms_output.put_line('Street: ' || residence.street);
    dbms_output.put_line('City: ' || residence.city);
    dbms_output.put_line('State: ' || residence.state);
    dbms_output.put_line('Pincode: ' || residence.pincode);
END;  
/
  
DECLARE 
    cust customer;
    residence address;
    
BEGIN
    residence := address('103A', 'Imadol', 'Lalitpur', 'Bagmati', '103123');
    
    cust := customer('101', 'Aarohan', '123123123', residence);
    dbms_output.put_line('Code: ' || cust.code);
    dbms_output.put_line('Name: ' || cust.name);
    dbms_output.put_line('Contact Number: ' || cust.contact_no);
    dbms_output.put_line('Address: ' || cust.addr.street || ', ' || cust.addr.city);
END; 


    
    
    
    
    