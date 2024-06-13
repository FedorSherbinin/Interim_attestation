-- Выбор базы данных
USE test_db;

-- Удаляем таблицу, если она уже существует
DROP TABLE IF EXISTS time_data;

-- Создаем таблицу заново
CREATE TABLE time_data (
    id INT PRIMARY KEY,
    seconds INT
);

-- Вставляем примерные данные
INSERT INTO time_data (id, seconds) VALUES (1, 123456);

-- Запрос для форматирования секунд в дни, часы, минуты, секунды
SELECT 
    seconds,
    FLOOR(seconds / 86400) AS days,
    FLOOR((seconds % 86400) / 3600) AS hours,
    FLOOR((seconds % 3600) / 60) AS minutes,
    (seconds % 60) AS seconds
FROM time_data;

-- Запрос для форматирования в одну строку
SELECT 
    seconds,
    CONCAT(
        FLOOR(seconds / 86400), ' days ',
        FLOOR((seconds % 86400) / 3600), ' hours ',
        FLOOR((seconds % 3600) / 60), ' minutes ',
        (seconds % 60), ' seconds'
    ) AS formatted_time
FROM time_data;

DROP PROCEDURE IF EXISTS print_even_numbers;

DELIMITER //

CREATE PROCEDURE print_even_numbers()
BEGIN
    DECLARE i INT DEFAULT 2;
    CREATE TEMPORARY TABLE EvenNumbers (even_number INT);

    WHILE i <= 10 DO
        INSERT INTO EvenNumbers (even_number) VALUES (i);
        SET i = i + 2;
    END WHILE;

    -- Выборка данных из временной таблицы
    SELECT even_number FROM EvenNumbers;

    -- Удаление временной таблицы
    DROP TEMPORARY TABLE EvenNumbers;
END //

DELIMITER ;

CALL print_even_numbers();
