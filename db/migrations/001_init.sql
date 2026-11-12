-- Script de criação do banco (entregável do enunciado). Rodado automaticamente pelo Compose.
CREATE TABLE IF NOT EXISTS users (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email         TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TYPE video_status AS ENUM ('PENDING', 'PROCESSING', 'DONE', 'FAILED');

CREATE TABLE IF NOT EXISTS videos (
    id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id           UUID NOT NULL REFERENCES users(id),
    original_filename TEXT NOT NULL,
    status            video_status NOT NULL DEFAULT 'PENDING',
    source_key        TEXT NOT NULL,          -- objeto do vídeo no storage
    result_key        TEXT,                   -- objeto do zip no storage
    frame_count       INTEGER,
    params            JSONB NOT NULL DEFAULT '{}'::jsonb,  -- intervalo, formato, modo
    error_message     TEXT,
    attempts          INTEGER NOT NULL DEFAULT 0,
    created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_videos_user_created ON videos (user_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_videos_status ON videos (status);
