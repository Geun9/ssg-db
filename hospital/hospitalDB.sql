USE hospital;

-- 의사 테이블
CREATE TABLE doctors
(
    doctor_id   INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '의사 ID',
    major_treat VARCHAR(10)  NOT NULL COMMENT '담당 진료 과목',
    name        VARCHAR(10)  NOT NULL COMMENT '의사 이름',
    gender      CHAR(1)      NOT NULL COMMENT '의사 성별 (M, F, N)',
    phone       VARCHAR(20)  NOT NULL COMMENT '의사 전화번호',
    email       VARCHAR(20)  NOT NULL UNIQUE COMMENT '의사 이메일',
    position    VARCHAR(10)  NOT NULL COMMENT '의사 직급',
    PRIMARY KEY (doctor_id)
);

-- 간호사 테이블
CREATE TABLE nurses
(
    nurse_id      INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '간호사 ID',
    assigned_task VARCHAR(20)  NOT NULL COMMENT '담당 업무',
    name          VARCHAR(10)  NOT NULL COMMENT '간호사 이름',
    gender        CHAR(1)      NOT NULL COMMENT '간호사 성별 (M, F, N)',
    phone         VARCHAR(20)  NOT NULL COMMENT '간호사 전화번호',
    email         VARCHAR(20)  NOT NULL UNIQUE COMMENT '간호사 이메일',
    position      VARCHAR(10)  NOT NULL COMMENT '간호사 직급',
    PRIMARY KEY (nurse_id)
);


-- 환자 테이블
CREATE TABLE patients
(
    patient_id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '환자 ID',
    nurse_id   INT UNSIGNED NOT NULL COMMENT '간호사 ID',
    doctor_id  INT UNSIGNED NOT NULL COMMENT '의사 ID',
    name       VARCHAR(10)  NOT NULL COMMENT '환자 이름',
    gender     CHAR(1)      NOT NULL COMMENT '환자 성별 (M, F, N)',
    residentID VARCHAR(15)  NOT NULL UNIQUE COMMENT '환자 주민등록번호',
    address    VARCHAR(40)  NOT NULL COMMENT '환자 주소',
    phone      VARCHAR(20)  NOT NULL COMMENT '환자 전화번호',
    email      VARCHAR(20) NOT NULL UNIQUE COMMENT '환자 이메일',
    job        VARCHAR(15) COMMENT '환자 직업',
    PRIMARY KEY (patient_id),
    FOREIGN KEY (nurse_id) REFERENCES nurses (nurse_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors (doctor_id)
);

-- 진료 테이블
CREATE TABLE treatments
(
    treatment_id   INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '진료 ID',
    patient_id     INT UNSIGNED NOT NULL COMMENT '환자 ID',
    doctor_id      INT UNSIGNED NOT NULL COMMENT '의사 ID',
    contents       VARCHAR(255) NOT NULL COMMENT '진료 내용',
    treatment_date DATE         NOT NULL COMMENT '진료 날짜',
    PRIMARY KEY (treatment_id),
    FOREIGN KEY (patient_id) REFERENCES patients (patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors (doctor_id)
);

-- 차트 테이블
CREATE TABLE charts
(
    chart_id     INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '차트 ID',
    treatment_id INT UNSIGNED NOT NULL COMMENT '진료 ID',
    doctor_id    INT UNSIGNED NOT NULL COMMENT '의사 ID',
    patient_id   INT UNSIGNED NOT NULL COMMENT '환자 ID',
    nurse_id     INT UNSIGNED NOT NULL COMMENT '간호사 ID',
    contents     VARCHAR(255) NOT NULL COMMENT '차트 내용',
    PRIMARY KEY (chart_id),
    FOREIGN KEY (treatment_id) REFERENCES treatments (treatment_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors (doctor_id),
    FOREIGN KEY (patient_id) REFERENCES patients (patient_id),
    FOREIGN KEY (nurse_id) REFERENCES nurses (nurse_id)
);
