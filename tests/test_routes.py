from fastapi.testclient import TestClient


def test_openapi_includes_jd_upload_route(client: TestClient) -> None:
    response = client.get("/openapi.json")

    assert response.status_code == 200
    assert "/api/v1/jd/upload" in response.json()["paths"]