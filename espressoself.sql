CREATE DATABASE ESPRESSOSELF;

USE ESPRESSOSELF;

CREATE TABLE  orders  (
     rowid  int  NOT NULL ,
     order_id  varchar(20)  NOT NULL ,
     created_at  datetime  NOT NULL ,
	 item_id  varchar(20)  NOT NULL ,
	 quantity  int  NOT NULL ,
	 cust_name varchar(30) NOT NULL,
	 in_or_out varchar(5),
    CONSTRAINT  PK_orders  PRIMARY KEY CLUSTERED (
         rowid  ASC
    )
);

CREATE TABLE  items  (
     item_id  varchar(20)  NOT NULL ,
     sku  varchar(50)  NOT NULL ,
     item_name  varchar(50)  NOT NULL ,
     item_cat  varchar(50)  NOT NULL ,
     item_size  varchar(20)  NOT NULL ,
     item_price  decimal(5,2)  NOT NULL ,
    CONSTRAINT  PK_item  PRIMARY KEY CLUSTERED (
         item_id  ASC
    )
);

CREATE TABLE  recipe  (
     row_id  int  NOT NULL ,
     recipe_id  varchar(20)  NOT NULL ,
     ing_id  varchar(10)  NOT NULL ,
     quantity  int  NOT NULL ,
    CONSTRAINT  PK_recipe  PRIMARY KEY CLUSTERED (
         row_id  ASC
    )
);

CREATE TABLE  ingredients  (
     ing_id  varchar(10)  NOT NULL ,
     ing_name  varchar(200)  NOT NULL ,
     ing_weight  int  NOT NULL ,
     ing_meas  varchar(10)  NOT NULL ,
     ing_price  decimal(5,2)  NOT NULL ,
    CONSTRAINT  PK_ingredients  PRIMARY KEY CLUSTERED (
         ing_id  ASC
    )
);

CREATE TABLE  inventory  (
     inv_id  varchar(10)  NOT NULL ,
     ing_id  varchar(10)  NOT NULL ,
     quantity  int  NOT NULL ,
    CONSTRAINT  PK_inventory  PRIMARY KEY CLUSTERED (
         inv_id  ASC
    )
);

CREATE TABLE  rota  (
     row_id  int  NOT NULL ,
     rota_id  varchar(20)  NOT NULL ,
     date  datetime  NOT NULL ,
     shift_id  varchar(20)  NOT NULL ,
     staff_id  varchar(20)  NOT NULL ,
    CONSTRAINT  PK_rota  PRIMARY KEY CLUSTERED (
         row_id  ASC
    )
);

CREATE TABLE  staff  (
     staff_id  varchar(20)  NOT NULL ,
     first_name  varchar(50)  NOT NULL ,
     last_name  varchar(50)  NOT NULL ,
     position  varchar(100)  NOT NULL ,
     sal_per_hour  decimal(5,2)  NOT NULL ,
    CONSTRAINT  PK_staff  PRIMARY KEY CLUSTERED (
         staff_id  ASC
    )
);

CREATE TABLE  shift  (
     shift_id  varchar(20)  NOT NULL ,
     day_of_week  varchar(10)  NOT NULL ,
     start_time  time  NOT NULL ,
     end_time  time  NOT NULL ,
    CONSTRAINT  PK_shift  PRIMARY KEY CLUSTERED (
         shift_id  ASC
    )
);

ALTER TABLE orders 
ADD CONSTRAINT FK_orders_item_id 
FOREIGN KEY (item_id) 
REFERENCES items(item_id);

ALTER TABLE recipe
ADD CONSTRAINT FK_recipe_ing_id
FOREIGN KEY (ing_id)
REFERENCES ingredients(ing_id);


CREATE INDEX idx_recipe_recipe_id ON recipe(recipe_id);
ALTER TABLE items
ADD CONSTRAINT FK_item_recipe_id
FOREIGN KEY (sku)
REFERENCES recipe(recipe_id);

ALTER TABLE inventory
ADD CONSTRAINT FK_inventory_ing_id
FOREIGN KEY (ing_id)
REFERENCES recipe(ing_id);

CREATE INDEX idx_orders_date ON orders(created_at);
ALTER TABLE rota
ADD CONSTRAINT FK_rota_date
FOREIGN KEY (date)
REFERENCES orders(created_at);

CREATE INDEX idx_rota_staff_id ON rota(staff_id);
ALTER TABLE staff
ADD CONSTRAINT FK_staff_staff_id
FOREIGN KEY (staff_id)
REFERENCES rota(staff_id);

CREATE INDEX idx_rota_shift_id ON rota(shift_id);
ALTER TABLE shift
ADD CONSTRAINT FK_shift_shift_id
FOREIGN KEY (shift_id)
REFERENCES rota(shift_id);
 
