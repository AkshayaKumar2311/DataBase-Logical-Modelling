-- Generated by Oracle SQL Developer Data Modeler 19.2.0.182.1216
--   at:        2020-05-13 01:00:04 AEST
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g
-- 31021301
-- Akshaya Kumar Chandrasekaran

set echo on;
spool mau_schema_output.txt


DROP TABLE artist CASCADE CONSTRAINTS;

DROP TABLE artwork CASCADE CONSTRAINTS;

DROP TABLE artwork_style CASCADE CONSTRAINTS;

DROP TABLE customer CASCADE CONSTRAINTS;

DROP TABLE exhibition CASCADE CONSTRAINTS;

DROP TABLE gallery CASCADE CONSTRAINTS;

DROP TABLE sale CASCADE CONSTRAINTS;

DROP TABLE status CASCADE CONSTRAINTS;

CREATE TABLE artist (
    artist_no             NUMBER(7) NOT NULL,
    artist_title          CHAR(5) NOT NULL,
    artist_fname          VARCHAR2(50),
    artist_gname          VARCHAR2(50),
    artist_street         VARCHAR2(10) NOT NULL,
    artist_city           VARCHAR2(30) NOT NULL,
    artist_state          VARCHAR2(30) NOT NULL,
    artist_postcode       VARCHAR2(10) NOT NULL,
    artist_phoneno        NUMBER(10),
    artist_currentstock   NUMBER(3) NOT NULL
);

COMMENT ON COLUMN artist.artist_no IS
    'PK of Artist table artist_no';

COMMENT ON COLUMN artist.artist_title IS
    'artist_title';

COMMENT ON COLUMN artist.artist_fname IS
    'artist first name';

COMMENT ON COLUMN artist.artist_gname IS
    'Artist given name';

COMMENT ON COLUMN artist.artist_street IS
    'Artist Street number';

COMMENT ON COLUMN artist.artist_city IS
    'Artist city ';

COMMENT ON COLUMN artist.artist_state IS
    'artist state';

COMMENT ON COLUMN artist.artist_postcode IS
    'artist postcode ';

COMMENT ON COLUMN artist.artist_phoneno IS
    'artist phone number ';

COMMENT ON COLUMN artist.artist_currentstock IS
    'current stocks present for the artist';

ALTER TABLE artist ADD CONSTRAINT artist_pk PRIMARY KEY ( artist_no );

CREATE TABLE artwork (
    artwork_no           NUMBER(7) NOT NULL,
    artist_no            NUMBER(7) NOT NULL,
    artwork_title        VARCHAR2(50) NOT NULL,
    artwork_acceptdate   DATE NOT NULL,
    artwork_mrp          NUMBER(10, 2) NOT NULL,
    artwork_mediadesc    VARCHAR2(30) NOT NULL,
    style_id             NUMBER(7) NOT NULL
);

COMMENT ON COLUMN artwork.artwork_no IS
    'Artwork Number PK';

COMMENT ON COLUMN artwork.artist_no IS
    'PK of Artist table artist_no';

COMMENT ON COLUMN artwork.artwork_title IS
    'artwork title';

COMMENT ON COLUMN artwork.artwork_acceptdate IS
    'artwork accept date';

COMMENT ON COLUMN artwork.artwork_mrp IS
    'min price of artwork';

COMMENT ON COLUMN artwork.artwork_mediadesc IS
    'media description';

COMMENT ON COLUMN artwork.style_id IS
    '(surrogate key)PK of the style table : style_id ';

ALTER TABLE artwork ADD CONSTRAINT artwork_pk PRIMARY KEY ( artwork_no,
                                                            artist_no );

CREATE TABLE artwork_style (
    style_id        NUMBER(7) NOT NULL,
    artwork_style   VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN artwork_style.style_id IS
    '(surrogate key)PK of the style table : style_id ';

COMMENT ON COLUMN artwork_style.artwork_style IS
    'style of art : Parent or child';

ALTER TABLE artwork_style ADD CONSTRAINT artwork_style_pk PRIMARY KEY ( style_id );

CREATE TABLE customer (
    cust_id         NUMBER(7) NOT NULL,
    cust_title      CHAR(5) NOT NULL,
    cust_fname      VARCHAR2(30),
    cust_gname      VARCHAR2(30),
    cust_street     VARCHAR2(10) NOT NULL,
    cust_city       VARCHAR2(30) NOT NULL,
    cust_state      VARCHAR2(30) NOT NULL,
    cust_postcode   VARCHAR2(10) NOT NULL,
    cust_phoneno    NUMBER(10) NOT NULL,
    cust_bname      VARCHAR2(30)
);

COMMENT ON COLUMN customer.cust_id IS
    'PK of cutomer table : cust_id';

COMMENT ON COLUMN customer.cust_title IS
    'title for customer';

COMMENT ON COLUMN customer.cust_fname IS
    'first name of customer';

COMMENT ON COLUMN customer.cust_gname IS
    'given name of customer';

COMMENT ON COLUMN customer.cust_street IS
    'customer street';

COMMENT ON COLUMN customer.cust_city IS
    'customer city';

COMMENT ON COLUMN customer.cust_state IS
    'customer state';

COMMENT ON COLUMN customer.cust_postcode IS
    'customer post code';

COMMENT ON COLUMN customer.cust_phoneno IS
    'phone number of customer';

COMMENT ON COLUMN customer.cust_bname IS
    'business name of customer';

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( cust_id );

CREATE TABLE exhibition (
    exhibit_id                NUMBER(7) NOT NULL,
    artist_no                 NUMBER(7) NOT NULL,
    artwork_no                NUMBER(7) NOT NULL,
    date_exhibition_started   DATE NOT NULL,
    date_exhibition_ended     DATE,
    featured_in_catalog       VARCHAR2(5) NOT NULL,
    gallery_id                NUMBER(7) NOT NULL
);

ALTER TABLE exhibition
    ADD CONSTRAINT chk_feature_catalog CHECK ( featured_in_catalog IN (
        'No',
        'Yes'
    ) );

COMMENT ON COLUMN exhibition.exhibit_id IS
    'Surrogate key : PK of exhibition table';

COMMENT ON COLUMN exhibition.artist_no IS
    'PK of Artist table artist_no';

COMMENT ON COLUMN exhibition.artwork_no IS
    'Artwork Number PK';

COMMENT ON COLUMN exhibition.date_exhibition_started IS
    'PK of this table : exhibition start date';

COMMENT ON COLUMN exhibition.date_exhibition_ended IS
    'exhibition end date';

COMMENT ON COLUMN exhibition.featured_in_catalog IS
    'featured in catalog';

COMMENT ON COLUMN exhibition.gallery_id IS
    'PK of gallery table : gallery_id';

ALTER TABLE exhibition ADD CONSTRAINT exhibition_pk PRIMARY KEY ( exhibit_id );

ALTER TABLE exhibition
    ADD CONSTRAINT nk_exhibition UNIQUE ( date_exhibition_started,
                                          artist_no,
                                          artwork_no );

CREATE TABLE gallery (
    gallery_id             NUMBER(7) NOT NULL,
    gallery_name           VARCHAR2(50) NOT NULL,
    gallery_street         VARCHAR2(15) NOT NULL,
    gallery_town           VARCHAR2(20) NOT NULL,
    gallery_state          VARCHAR2(30) NOT NULL,
    gallery_manager_name   VARCHAR2(60) NOT NULL,
    gallery_phoneno        NUMBER(10) NOT NULL,
    gallery_commission     NUMBER(8, 2) NOT NULL,
    gallery_open_time      DATE NOT NULL,
    gallery_close_time     DATE NOT NULL
);

COMMENT ON COLUMN gallery.gallery_id IS
    'PK of gallery table : gallery_id';

COMMENT ON COLUMN gallery.gallery_name IS
    'name of gallery';

COMMENT ON COLUMN gallery.gallery_street IS
    'gallery street';

COMMENT ON COLUMN gallery.gallery_town IS
    'gallery town';

COMMENT ON COLUMN gallery.gallery_state IS
    'gallery state';

COMMENT ON COLUMN gallery.gallery_manager_name IS
    'gallery manager name';

COMMENT ON COLUMN gallery.gallery_phoneno IS
    'gallery phone number';

COMMENT ON COLUMN gallery.gallery_commission IS
    'commission for the gallery';

COMMENT ON COLUMN gallery.gallery_open_time IS
    'Opening time';

COMMENT ON COLUMN gallery.gallery_close_time IS
    'Gallery close time';

ALTER TABLE gallery ADD CONSTRAINT gallery_pk PRIMARY KEY ( gallery_id );

CREATE TABLE sale (
    sale_id        NUMBER(7) NOT NULL,
    date_of_sale   DATE NOT NULL,
    sale_price     NUMBER(8, 2) NOT NULL,
    cust_id        NUMBER(7) NOT NULL,
    exhibit_id     NUMBER(7) NOT NULL
);

COMMENT ON COLUMN sale.sale_id IS
    'PK of sale table : sale_id';

COMMENT ON COLUMN sale.date_of_sale IS
    'sale date';

COMMENT ON COLUMN sale.sale_price IS
    'sale price ';

COMMENT ON COLUMN sale.cust_id IS
    'PK of cutomer table : cust_id';

COMMENT ON COLUMN sale.exhibit_id IS
    'Surrogate key : PK of exhibition table';

CREATE UNIQUE INDEX sale__idx ON
    sale (
        exhibit_id
    ASC );

ALTER TABLE sale ADD CONSTRAINT sale_pk PRIMARY KEY ( sale_id );

CREATE TABLE status (
    status_id        NUMBER(7) NOT NULL,
    status_date      DATE NOT NULL,
    artwork_no       NUMBER(7) NOT NULL,
    artist_no        NUMBER(7) NOT NULL,
    artwork_status   VARCHAR2(30) NOT NULL,
    gallery_id       NUMBER(7)
);

ALTER TABLE status
    ADD CONSTRAINT chk_status_artworkstatus CHECK ( artwork_status IN (
        'in MAU warehouse',
        'in transit',
        'on display by a gallery',
        'returned to artist',
        'sold'
    ) );

COMMENT ON COLUMN status.status_id IS
    'Surrogate key : PK of status table';

COMMENT ON COLUMN status.status_date IS
    'PK of the status table:  status_date';

COMMENT ON COLUMN status.artwork_no IS
    'Artwork Number PK';

COMMENT ON COLUMN status.artist_no IS
    'PK of Artist table artist_no';

COMMENT ON COLUMN status.artwork_status IS
    'current status on artwork';

COMMENT ON COLUMN status.gallery_id IS
    'PK of gallery table : gallery_id';

CREATE UNIQUE INDEX status__idx ON
    status (
        gallery_id
    ASC );

ALTER TABLE status ADD CONSTRAINT status_pk PRIMARY KEY ( status_id );

ALTER TABLE status
    ADD CONSTRAINT nk_status UNIQUE ( status_date,
                                      artwork_no,
                                      artist_no );

ALTER TABLE artwork
    ADD CONSTRAINT artist_artistcode FOREIGN KEY ( artist_no )
        REFERENCES artist ( artist_no );

ALTER TABLE exhibition
    ADD CONSTRAINT artwork_exhibition FOREIGN KEY ( artwork_no,
                                                    artist_no )
        REFERENCES artwork ( artwork_no,
                             artist_no );

ALTER TABLE status
    ADD CONSTRAINT artwork_status FOREIGN KEY ( artwork_no,
                                                artist_no )
        REFERENCES artwork ( artwork_no,
                             artist_no );

ALTER TABLE sale
    ADD CONSTRAINT customer_sale FOREIGN KEY ( cust_id )
        REFERENCES customer ( cust_id );

ALTER TABLE sale
    ADD CONSTRAINT exhibition_sale FOREIGN KEY ( exhibit_id )
        REFERENCES exhibition ( exhibit_id );

ALTER TABLE exhibition
    ADD CONSTRAINT gallery_exhibition FOREIGN KEY ( gallery_id )
        REFERENCES gallery ( gallery_id );

ALTER TABLE status
    ADD CONSTRAINT gallery_status FOREIGN KEY ( gallery_id )
        REFERENCES gallery ( gallery_id );

ALTER TABLE artwork
    ADD CONSTRAINT style_artwork FOREIGN KEY ( style_id )
        REFERENCES artwork_style ( style_id );

spool off;
set echo off;

-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             8
-- CREATE INDEX                             2
-- ALTER TABLE                             20
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
