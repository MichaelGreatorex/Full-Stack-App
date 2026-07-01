from pathlib import Path
from typing import Literal, Optional, Union

from pydantic import Field, field_validator
from pydantic_settings import BaseSettings, SettingsConfigDict


BACKEND_DIR = Path(__file__).resolve().parents[2]


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=BACKEND_DIR / ".env",
        env_file_encoding="utf-8",
        extra="ignore",
    )

    environment: Literal["local", "test", "production"] = "local"

    app_name: str = "AI Interview Coach"
    app_version: str = "0.1.0"
    debug: bool = False

    openai_api_key: Optional[str] = None

    aws_region: str = "eu-west-2"
    s3_bucket_name: Optional[str] = None

    database_url: Optional[str] = None

    allowed_origins: list[str] = Field(default_factory=lambda: ["http://localhost:3000"])

    @field_validator("openai_api_key", "s3_bucket_name", "database_url", mode="before")
    @classmethod
    def empty_strings_to_none(cls, value: Optional[str]) -> Optional[str]:
        if isinstance(value, str) and not value.strip():
            return None
        return value

    @field_validator("allowed_origins", mode="before")
    @classmethod
    def parse_allowed_origins(cls, value: Union[str, list[str]]) -> list[str]:
        if isinstance(value, str):
            return [origin.strip() for origin in value.split(",") if origin.strip()]
        return value


settings = Settings()
