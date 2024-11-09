CREATE TABLE avatars ( avatar_id0 SERIAL PRIMARY KEY NOT NULL );

CREATE TABLE users (
    user_id0 BIGSERIAL PRIMARY KEY NOT NULL,
    created_on0 DATE NOT NULL DEFAULT CURRENT_DATE,
    updated_on0 DATE NOT NULL DEFAULT CURRENT_DATE,
    avatar_id0 INT DEFAULT 1 NOT NULL,
    version0 INT DEFAULT 1 NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    is_verfied BOOLEAN NOT NULL DEFAULT false,
    last_login DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (avatar_id0) REFERENCES avatars (avatar_id0)
);

CREATE TABLE users_versions (
    user_version_id0 BIGSERIAL PRIMARY KEY NOT NULL,
    created_on0 DATE NOT NULL DEFAULT CURRENT_DATE,
    user_id0 BIGINT NOT NULL,
    avatar_id0 INT DEFAULT 1 NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    password VARCHAR(100),
    is_verfied BOOLEAN DEFAULT false,
    version INT DEFAULT 1,
    FOREIGN KEY (avatar_id0) REFERENCES avatars (avatar_id0),
    FOREIGN KEY (user_id0) REFERENCES users (user_id0)
);