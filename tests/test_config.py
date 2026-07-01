from app.core.config import Settings


def test_settings_parse_comma_separated_allowed_origins() -> None:
    settings = Settings(allowed_origins="http://localhost:3000, https://example.com")

    assert settings.allowed_origins == ["http://localhost:3000", "https://example.com"]


def test_settings_convert_empty_strings_to_none() -> None:
    settings = Settings(openai_api_key="", s3_bucket_name="   ", database_url="")

    assert settings.openai_api_key is None
    assert settings.s3_bucket_name is None
    assert settings.database_url is None