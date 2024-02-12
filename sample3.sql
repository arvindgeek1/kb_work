CREATE TABLE Department (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE Employee (
    employee_id SERIAL PRIMARY KEY,
    department_id INT NOT NULL REFERENCES Department(department_id),
    employee_name VARCHAR(100) NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(10, 2),
    CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

CREATE TABLE Project (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    department_id INT NOT NULL REFERENCES Department(department_id),
    CONSTRAINT fk_department_project FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

CREATE TABLE Task (
    task_id SERIAL PRIMARY KEY,
    task_name VARCHAR(100) NOT NULL,
    project_id INT NOT NULL REFERENCES Project(project_id),
    CONSTRAINT fk_project_task FOREIGN KEY (project_id) REFERENCES Project(project_id)
);

CREATE TABLE Employee_Task (
    employee_id INT NOT NULL REFERENCES Employee(employee_id),
    task_id INT NOT NULL REFERENCES Task(task_id),
    PRIMARY KEY (employee_id, task_id),
    CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    CONSTRAINT fk_task FOREIGN KEY (task_id) REFERENCES Task(task_id)
);

CREATE TABLE Address (
    address_id SERIAL PRIMARY KEY,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    zip_code VARCHAR(20) NOT NULL
);

CREATE TABLE Employee_Address (
    employee_id INT NOT NULL REFERENCES Employee(employee_id),
    address_id INT NOT NULL REFERENCES Address(address_id),
    PRIMARY KEY (employee_id, address_id),
    CONSTRAINT fk_employee_address_employee FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    CONSTRAINT fk_employee_address_address FOREIGN KEY (address_id) REFERENCES Address(address_id)
);

CREATE TABLE Manager (
    manager_id SERIAL PRIMARY KEY,
    employee_id INT NOT NULL UNIQUE REFERENCES Employee(employee_id)
);

CREATE TABLE Employee_Manager (
    employee_id INT NOT NULL REFERENCES Employee(employee_id),
    manager_id INT NOT NULL REFERENCES Manager(manager_id),
    PRIMARY KEY (employee_id),
    CONSTRAINT fk_employee_manager_employee FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    CONSTRAINT fk_employee_manager_manager FOREIGN KEY (manager_id) REFERENCES Manager(manager_id)
);

CREATE TABLE Project_Manager (
    project_id INT NOT NULL REFERENCES Project(project_id),
    manager_id INT NOT NULL REFERENCES Manager(manager_id),
    PRIMARY KEY (project_id),
    CONSTRAINT fk_project_manager_project FOREIGN KEY (project_id) REFERENCES Project(project_id),
    CONSTRAINT fk_project_manager_manager FOREIGN KEY (manager_id) REFERENCES Manager(manager_id)
);

CREATE TABLE Task_Assignment (
    assignment_id SERIAL PRIMARY KEY,
    task_id INT NOT NULL REFERENCES Task(task_id),
    employee_id INT NOT NULL REFERENCES Employee(employee_id),
    start_date DATE NOT NULL,
    end_date DATE,
    CONSTRAINT fk_task_assignment_task FOREIGN KEY (task_id) REFERENCES Task(task_id),
    CONSTRAINT fk_task_assignment_employee FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Task_Dependency (
    dependency_id SERIAL PRIMARY KEY,
    task_id INT NOT NULL REFERENCES Task(task_id),
    dependent_task_id INT NOT NULL REFERENCES Task(task_id),
    CONSTRAINT fk_task_dependency_task FOREIGN KEY (task_id) REFERENCES Task(task_id),
    CONSTRAINT fk_task_dependency_dependent_task FOREIGN KEY (dependent_task_id) REFERENCES Task(task_id)
);

CREATE TABLE Skill (
    skill_id SERIAL PRIMARY KEY,
    skill_name VARCHAR(100) NOT NULL
);

CREATE TABLE Employee_Skill (
    employee_id INT NOT NULL REFERENCES Employee(employee_id),
    skill_id INT NOT NULL REFERENCES Skill(skill_id),
    proficiency_level INT,
    PRIMARY KEY (employee_id, skill_id),
    CONSTRAINT fk_employee_skill_employee FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    CONSTRAINT fk_employee_skill_skill FOREIGN KEY (skill_id) REFERENCES Skill(skill_id)
);

CREATE TABLE Customer (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(20),
    address_id INT NOT NULL REFERENCES Address(address_id)
);

CREATE TABLE Product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES Customer(customer_id),
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Order_Item (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES Orders(order_id),
    product_id INT NOT NULL REFERENCES Product(product_id),
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_order_item_order FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    CONSTRAINT fk_order_item_product FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Supplier (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_name VARCHAR(100),
    email VARCHAR(255),
    phone_number VARCHAR(20),
    address_id INT NOT NULL REFERENCES Address(address_id)
);

CREATE TABLE Purchase (
    purchase_id SERIAL PRIMARY KEY,
    supplier_id INT NOT NULL REFERENCES Supplier(supplier_id),
    purchase_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Purchase_Item (
    purchase_item_id SERIAL PRIMARY KEY,
    purchase_id INT NOT NULL REFERENCES Purchase(purchase_id),
    product_id INT NOT NULL REFERENCES Product(product_id),
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_purchase_item_purchase FOREIGN KEY (purchase_id) REFERENCES Purchase(purchase_id),
    CONSTRAINT fk_purchase_item_product FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Category (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE Product_Category (
    product_id INT NOT NULL REFERENCES Product(product_id),
    category_id INT NOT NULL REFERENCES Category(category_id),
    PRIMARY KEY (product_id, category_id),
    CONSTRAINT fk_product_category_product FOREIGN KEY (product_id) REFERENCES Product(product_id),
    CONSTRAINT fk_product_category_category FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

