-- create user carmanager@localhost identified by 'carmanager';
-- create database carRent;
-- grant all privileges on carRent.* to carmanager@localhost with grant option;
-- flush privileges;

USE carRent;


CREATE TABLE customer
(
    license_id          VARCHAR(20) NOT NULL COMMENT '고객 운전 면허증 ID',
    name                VARCHAR(10)  NOT NULL COMMENT '고객명',
    address             VARCHAR(50)  NOT NULL COMMENT '고객 주소',
    phone               VARCHAR(20)  NOT NULL COMMENT '고객 전화 번호',
    email               VARCHAR(20)  NOT NULL UNIQUE COMMENT '고객 이메일',
    last_usage_date     DATE         NOT NULL COMMENT '이전 캠핑카 사용 날짜',
    last_usage_car_type VARCHAR(10)  NOT NULL COMMENT '이전 사용 캠핑카 종류',
    PRIMARY KEY (license_id)
) COMMENT ='고객';


CREATE TABLE rental_company
(
    id            INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '캠핑카 대여 회사 ID',
    name          VARCHAR(30)  NOT NULL COMMENT '회사명',
    address       VARCHAR(50)  NOT NULL COMMENT '주소',
    phone         VARCHAR(20)  NOT NULL COMMENT '전화번호',
    manager_name  VARCHAR(20)  NOT NULL COMMENT '담당자 이름',
    manager_email VARCHAR(20)  NOT NULL UNIQUE COMMENT '담당자 이메일',
    PRIMARY KEY (id)
) COMMENT ='캠핑카 대여 회사';


CREATE TABLE camping_car
(
    id                 INT UNSIGNED   NOT NULL AUTO_INCREMENT COMMENT '캠핑카 ID',
    rental_company_id  INT UNSIGNED   NOT NULL COMMENT '캠핑카 대여 회사 ID (rental_company 테이블의 id 참조)',
    name               VARCHAR(30)    NOT NULL COMMENT '캠핑카 이름',
    number             VARCHAR(10)    NOT NULL COMMENT '캠핑카 차량 번호',
    passenger_capacity INT UNSIGNED   NOT NULL COMMENT '캠핑카 승차 인원',
    image_url          VARCHAR(255)   NOT NULL COMMENT '캠핑카 이미지',
    details            TEXT           NOT NULL COMMENT '캠핑카 상세 정보',
    cost               DECIMAL(10, 2) NOT NULL COMMENT '캠핑카 대여 비용',
    registration_date  DATE           NOT NULL COMMENT '캠핑카 등록 일자',
    CONSTRAINT pk_cc PRIMARY KEY (id, rental_company_id)
) COMMENT ='캠핑카';

ALTER TABLE camping_car
    ADD CONSTRAINT fk_cc_rc FOREIGN KEY (rental_company_id) REFERENCES rental_company (id);


CREATE TABLE car_rental
(
    id                  INT UNSIGNED   NOT NULL AUTO_INCREMENT COMMENT '캠핑카 대여 ID',
    camping_car_id      INT UNSIGNED   NOT NULL COMMENT '캠핑카 ID (camping_car 테이블의 id 참조)',
    customer_license_id VARCHAR(20)   NOT NULL COMMENT '고객 운전 면허증 ID (customer 테이블의 license_id 참조)',
    rental_company_id   INT UNSIGNED   NOT NULL COMMENT '캠핑카 대여 회사 ID (rental_company 테이블의 id 참조)',
    rental_start_date   DATE           NOT NULL COMMENT '대여 시작일',
    rental_duration     INT UNSIGNED   NOT NULL COMMENT '대여 기간 (일)',
    amount              DECIMAL(10, 2) NOT NULL COMMENT '청구 요금',
    payment_due_date    DATE           NOT NULL COMMENT '납입 기한',
    additional_details  TEXT           NULL COMMENT '기타 청구 내역',
    additional_amount   VARCHAR(255)   NULL COMMENT '기타 청구 요금',
    PRIMARY KEY (id)
) COMMENT ='캠핑카 대여';

ALTER TABLE car_rental
    ADD CONSTRAINT fk_cr_cc FOREIGN KEY (camping_car_id) REFERENCES camping_car (id),
    ADD CONSTRAINT fk_cr_c FOREIGN KEY (customer_license_id) REFERENCES customer (license_id),
    ADD CONSTRAINT fk_cr_rc FOREIGN KEY (rental_company_id) REFERENCES rental_company (id);


CREATE TABLE repair_shop
(
    id            INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '캠핑카 정비소 ID',
    name          VARCHAR(30)  NOT NULL COMMENT '정비소명',
    address       VARCHAR(50)  NOT NULL COMMENT '정비소 주소',
    phone         VARCHAR(20)  NOT NULL COMMENT '정비소 전화번호',
    manager_name  VARCHAR(20)  NOT NULL COMMENT '담당자 이름',
    manager_email VARCHAR(20)  NOT NULL UNIQUE COMMENT '담당자 이메일',
    PRIMARY KEY (id)
) COMMENT ='캠핑카 정비소';


CREATE TABLE repair_info
(
    id                  INT UNSIGNED   NOT NULL AUTO_INCREMENT COMMENT '캠핑카 정비 정보 ID',
    camping_car_id      INT UNSIGNED   NOT NULL COMMENT '캠핑카 ID (camping_car 테이블의 id 참조)',
    repair_shop_id      INT UNSIGNED   NOT NULL COMMENT '캠핑카 정비소 ID (repair_shop 테이블의 id 참조)',
    rental_company_id   INT UNSIGNED   NOT NULL COMMENT '캠핑카 대여 회사 ID (rental_company 테이블의 id 참조)',
    customer_license_id VARCHAR(20)   NOT NULL COMMENT '고객 운전 면허증 ID (customer 테이블의 license_id 참조)',
    details             TEXT           NOT NULL COMMENT '정비 내역',
    repair_date         DATE           NOT NULL COMMENT '수리 날짜',
    cost                DECIMAL(10, 2) NOT NULL COMMENT '수리 비용',
    payment_due_date    DATE           NOT NULL COMMENT '납입 기한',
    additional_details  TEXT           NULL COMMENT '기타 정비 내역',
    PRIMARY KEY (id)
) COMMENT ='캠핑카 정비 정보';

ALTER TABLE repair_info
    ADD CONSTRAINT fk_ri_cc FOREIGN KEY (camping_car_id) REFERENCES camping_car (id),
    ADD CONSTRAINT fk_ri_rs FOREIGN KEY (repair_shop_id) REFERENCES repair_shop (id),
    ADD CONSTRAINT fk_ri_rc FOREIGN KEY (rental_company_id) REFERENCES rental_company (id),
    ADD CONSTRAINT fk_ri_c FOREIGN KEY (customer_license_id) REFERENCES customer (license_id);