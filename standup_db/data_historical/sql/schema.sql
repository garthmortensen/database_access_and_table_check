-- define schema
drop table if exists coordinated;
drop table if exists energy_historical;
drop table if exists concrete_historical;
drop table if exists labor_historical;
drop table if exists lumber_historical;
drop table if exists paint_historical;
drop table if exists shingles_historical;
drop table if exists steel_historical;

CREATE TABLE IF NOT EXISTS coordinated (
    id INTEGER PRIMARY KEY AUTOINCREMENT, -- surrogate key
    group_id INTEGER,
    date DATE,
	model TEXT,
	effective TEXT,
	whoami TEXT,
	status TEXT CHECK(status IN ('queued', 'running', 'pending', 'paused', 'complete', 'canceled', 'error', NULL))
);

CREATE TABLE IF NOT EXISTS energy_historical (
    id INTEGER PRIMARY KEY AUTOINCREMENT, -- surrogate key
    date DATE,
    effective TEXT,
    factory_price_energy DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS concrete_historical (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date DATE,
    effective TEXT,
    cost_limestone DECIMAL(10, 2),
    cost_clay DECIMAL(10, 2),
    cost_gypsum DECIMAL(10, 2),
    cost_iron_ore DECIMAL(10, 2),
    cost_fuel DECIMAL(10, 2),
    factory_price_energy DECIMAL(10, 2), -- updated
    factory_price_concrete DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS labor_historical (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
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

CREATE TABLE IF NOT EXISTS lumber_historical (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date DATE,
    effective TEXT,
    unemployment_rate DECIMAL(4, 1),
    housing_starts INT,
    interest_rate DECIMAL(3, 1),
    factory_price_lumber DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS paint_historical (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date DATE,
    effective TEXT,
    titanium_dioxide_price_index INT,
    factory_price_energy DECIMAL(10, 2),  -- updated
    inflation_rate DECIMAL(3, 1),
    factory_price_paint DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS shingles_historical (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date DATE,
    effective TEXT,
    cost_raw_material DECIMAL(10, 2),
    factory_price_energy DECIMAL(10, 2),  -- updated
    cost_labor DECIMAL(10, 2),
    cost_transportation DECIMAL(10, 2),
    factory_price_shingles DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS steel_historical (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date DATE,
    effective TEXT,
    cost_raw_material DECIMAL(10, 2),
    factory_price_energy DECIMAL(10, 2),  -- updated
    cost_labor DECIMAL(10, 2),
    cost_transportation DECIMAL(10, 2),
    factory_price_steel DECIMAL(10, 2)
);
