-- define schema
drop table if exists energy_predicted;
drop table if exists concrete_predicted;
drop table if exists labor_predicted;
drop table if exists lumber_predicted;
drop table if exists paint_predicted;
drop table if exists shingles_predicted;
drop table if exists steel_predicted;

CREATE TABLE IF NOT EXISTS energy_predicted (
    id INTEGER PRIMARY KEY AUTOINCREMENT, -- surrogate key
    date DATE,
    effective TEXT,
    factory_price_energy DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS concrete_predicted (
    id INTEGER PRIMARY KEY AUTOINCREMENT, -- surrogate key
    date DATE,
    effective TEXT,
    cost_limestone DECIMAL(10, 2),
    cost_clay DECIMAL(10, 2),
    cost_gypsum DECIMAL(10, 2),
    cost_iron_ore DECIMAL(10, 2),
    cost_fuel DECIMAL(10, 2),
    factory_price_energy DECIMAL(10, 2),
    factory_price_concrete DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS labor_predicted (
    id INTEGER PRIMARY KEY AUTOINCREMENT, -- surrogate key
    date DATE,
    effective TEXT,
    carpenters DECIMAL(10, 2),
    electricians DECIMAL(10, 2),
    plumbers DECIMAL(10, 2),
    hvac_technicians DECIMAL(10, 2),
    painters DECIMAL(10, 2),
    masons DECIMAL(10, 2),
    roofers DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS lumber_predicted (
    id INTEGER PRIMARY KEY AUTOINCREMENT, -- surrogate key
    date DATE,
    effective TEXT,
    unemployment_rate DECIMAL(4, 1),
    housing_starts INT,
    interest_rate DECIMAL(3, 1),
    factory_price_lumber DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS paint_predicted (
    id INTEGER PRIMARY KEY AUTOINCREMENT, -- surrogate key
    date DATE,
    effective TEXT,
    titanium_dioxide_price_index INT,
    factory_price_energy DECIMAL(10, 2),
    inflation_rate DECIMAL(3, 1),
    factory_price_paint DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS shingles_predicted (
    id INTEGER PRIMARY KEY AUTOINCREMENT, -- surrogate key
    date DATE,
    effective TEXT,
    cost_raw_material DECIMAL(10, 2),
    factory_price_energy DECIMAL(10, 2),
    cost_labor DECIMAL(10, 2),
    cost_transportation DECIMAL(10, 2),
    factory_price_shingles DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS steel_predicted (
    id INTEGER PRIMARY KEY AUTOINCREMENT, -- surrogate key
    date DATE,
    effective TEXT,
    cost_raw_material DECIMAL(10, 2),
    factory_price_energy DECIMAL(10, 2),
    cost_labor DECIMAL(10, 2),
    cost_transportation DECIMAL(10, 2),
    factory_price_steel DECIMAL(10, 2)
);

-- calculator results
CREATE TABLE IF NOT EXISTS calculator_predicted (
    id INTEGER PRIMARY KEY AUTOINCREMENT, -- surrogate key
    date DATE,
    effective TEXT,
    annual_sum DECIMAL(10, 2)
);
