CREATE TABLE IF NOT EXISTS verity_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(60) NOT NULL,
    verity_status BOOLEAN DEFAULT FALSE,
    last_verity TIMESTAMP NULL,
    UNIQUE KEY unique_identifier (identifier)
);