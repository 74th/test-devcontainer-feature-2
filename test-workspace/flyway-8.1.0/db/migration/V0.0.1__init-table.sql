-- ユーザーテーブル
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 旅行プランテーブル
CREATE TABLE travel_plans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    duration_days INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    max_participants INT DEFAULT 10,
    description TEXT,
    departure_date DATE NOT NULL,
    return_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 予約テーブル
CREATE TABLE reservations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    travel_plan_id INT NOT NULL,
    participants INT DEFAULT 1,
    total_amount DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'cancelled') DEFAULT 'pending',
    reservation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (travel_plan_id) REFERENCES travel_plans(id) ON DELETE CASCADE
);

-- インデックスの作成
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_travel_plans_destination ON travel_plans(destination);
CREATE INDEX idx_travel_plans_departure_date ON travel_plans(departure_date);
CREATE INDEX idx_reservations_user_id ON reservations(user_id);
CREATE INDEX idx_reservations_travel_plan_id ON reservations(travel_plan_id);
CREATE INDEX idx_reservations_status ON reservations(status);

-- サンプルデータの挿入
INSERT INTO users (name, email, phone) VALUES
('田中太郎', 'tanaka@example.com', '090-1234-5678'),
('佐藤花子', 'sato@example.com', '080-9876-5432'),
('鈴木一郎', 'suzuki@example.com', '070-1111-2222');

INSERT INTO travel_plans (title, destination, duration_days, price, max_participants, description, departure_date, return_date) VALUES
('沖縄リゾートツアー', '沖縄', 3, 89000.00, 20, '美しいビーチと琉球文化を楽しむ3日間の旅', '2024-03-15', '2024-03-17'),
('京都歴史探訪', '京都', 2, 45000.00, 15, '古都京都の寺院と伝統文化を巡る旅', '2024-04-20', '2024-04-21'),
('北海道グルメツアー', '北海道', 4, 125000.00, 12, '北海道の美味しい海鮮とラーメンを堪能する旅', '2024-05-10', '2024-05-13');

INSERT INTO reservations (user_id, travel_plan_id, participants, total_amount, status, notes) VALUES
(1, 1, 2, 178000.00, 'confirmed', '新婚旅行として利用'),
(2, 2, 1, 45000.00, 'pending', '一人旅を希望'),
(3, 3, 3, 375000.00, 'confirmed', '家族旅行で利用');
