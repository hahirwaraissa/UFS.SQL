 -- 1. Create Staff_and_Volunteers Table First (No Foreign Keys)
CREATE TABLE Staff_and_Volunteers (
    staff_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,       -- Unique identifier for each staff or volunteer
    name VARCHAR2(100) NOT NULL,                                        -- Name of the staff member or volunteer
    role VARCHAR2(100),                                                 -- Role of the staff member (e.g., manager, volunteer)
    hours_worked NUMBER,                                                -- Hours contributed by the volunteer or staff member
    assigned_farm_id NUMBER                                            -- Farm assigned to the staff or volunteer (Foreign Key will be added later)
);

-- 2. Create Farms Table (No Foreign Keys)
CREATE TABLE Farms (
    farm_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,    -- Unique identifier for each farm
    name VARCHAR2(100) NOT NULL,                                      -- Name of the farm location
    address VARCHAR2(255) NOT NULL,                                   -- Address of the farm
    total_planting_area NUMBER,                                       -- Area available for planting (in square meters)
    assigned_staff_id NUMBER                                          -- ID of the staff member assigned (Foreign Key will be added later)
);

-- 3. Create Crops Table (No Foreign Keys)
CREATE TABLE Crops (
    crop_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,       -- Unique identifier for each crop type
    name VARCHAR2(100) NOT NULL,                                        -- Name of the crop
    planting_schedule DATE,                                             -- Scheduled planting date
    growing_conditions VARCHAR2(255),                                   -- Description of ideal growing conditions
    average_yield NUMBER,                                               -- Average yield per planting cycle (in kg)
    farm_id NUMBER                                                     -- Farm ID where the crop is planted (Foreign Key will be added later)
);

-- 4. Create Harvests Table (No Foreign Keys)
CREATE TABLE Harvests (
    harvest_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,    -- Unique identifier for each harvest
    harvest_date DATE NOT NULL,                                         -- Date of the harvest
    yield_kg NUMBER,                                                    -- Yield in kilograms
    quality_rating NUMBER,                                              -- Quality rating of the harvested crop
    farm_id NUMBER,                                                     -- Farm ID where the harvest occurred (Foreign Key will be added later)
    crop_id NUMBER                                                      -- Crop ID harvested (Foreign Key will be added later)
);

-- 5. Create Inventory Table (No Foreign Keys)
CREATE TABLE Inventory (
    inventory_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,   -- Unique identifier for each inventory entry
    crop_id NUMBER,                                                     -- Crop ID (Foreign Key will be added later)
    quantity NUMBER,                                                    -- Quantity of the crop available
    freshness_status VARCHAR2(50),                                      -- Freshness status (e.g., "Fresh", "Expired")
    storage_location VARCHAR2(255)                                      -- Storage location details
);

-- 6. Create Clients Table (No Foreign Keys)
CREATE TABLE Clients (
    client_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,      -- Unique identifier for each client
    name VARCHAR2(100) NOT NULL,                                        -- Name of the client (restaurant/business/resident)
    contact_info VARCHAR2(255),                                         -- Contact information for the client
    order_preferences VARCHAR2(255),                                    -- Order preferences for the client
    payment_history CLOB                                               -- Record of payments made by the client
);

-- 7. Create Orders Table (No Foreign Keys)
CREATE TABLE Orders (
    order_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,       -- Unique identifier for each order
    client_id NUMBER,                                                   -- Client who placed the order (Foreign Key will be added later)
    crop_id NUMBER,                                                     -- Crop included in the order (Foreign Key will be added later)
    quantity NUMBER,                                                    -- Quantity of crops ordered
    order_date DATE,                                                   -- Date when the order was placed
    delivery_date DATE                                                  -- Scheduled delivery date
);

-- 8. Create Sustainability Metrics Table (No Foreign Keys)
CREATE TABLE Sustainability_Metrics (
    metric_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,      -- Unique identifier for each sustainability record
    farm_id NUMBER,                                                     -- Farm location for the metrics (Foreign Key will be added later)
    water_usage NUMBER,                                                 -- Water usage (liters)
    soil_health VARCHAR2(255),                                          -- Soil health information
    pesticide_usage NUMBER,                                             -- Pesticide usage (liters)
    fertilizer_usage NUMBER,                                            -- Fertilizer usage (kg)
    energy_use NUMBER                                                  -- Energy use (kWh)
);

-- 1. Add Foreign Key to Farms table for Staff_and_Volunteers
ALTER TABLE Farms
ADD CONSTRAINT fk_assigned_staff FOREIGN KEY (assigned_staff_id) 
    REFERENCES Staff_and_Volunteers(staff_id);

-- 2. Add Foreign Key to Crops table for Farms
ALTER TABLE Crops
ADD CONSTRAINT fk_farm_id FOREIGN KEY (farm_id) 
    REFERENCES Farms(farm_id);

-- 3. Add Foreign Key to Harvests table for Farms and Crops
ALTER TABLE Harvests
ADD CONSTRAINT fk_harvest_farm FOREIGN KEY (farm_id) 
    REFERENCES Farms(farm_id);

ALTER TABLE Harvests
ADD CONSTRAINT fk_harvest_crop FOREIGN KEY (crop_id) 
    REFERENCES Crops(crop_id);

-- 4. Add Foreign Key to Inventory table for Crops
ALTER TABLE Inventory
ADD CONSTRAINT fk_inventory_crop FOREIGN KEY (crop_id) 
    REFERENCES Crops(crop_id);

-- 5. Add Foreign Key to Orders table for Clients and Crops
ALTER TABLE Orders
ADD CONSTRAINT fk_order_client FOREIGN KEY (client_id) 
    REFERENCES Clients(client_id);

ALTER TABLE Orders
ADD CONSTRAINT fk_order_crop FOREIGN KEY (crop_id) 
    REFERENCES Crops(crop_id);

-- 6. Add Foreign Key to Sustainability_Metrics table for Farms
ALTER TABLE Sustainability_Metrics
ADD CONSTRAINT fk_sustainability_farm FOREIGN KEY (farm_id) 
    REFERENCES Farms(farm_id);

