from typing import Optional

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8", extra="ignore")

    app_name: str = "AI Interview Coach"
    app_version: str = "0.1.0"
    debug: bool = False

    openai_api_key: Optional[str] = None

    aws_region: str = "eu-west-2"
    s3_bucket_name: str = ""

    database_url: str = ""

    allowed_origins: list[str] = ["http://localhost:3000"]


settings = Settings()
