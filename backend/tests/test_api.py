from fastapi.testclient import TestClient

from backend.main import app


client = TestClient(app)


def test_health() -> None:
    assert client.get("/health").json() == {"status": "ok"}


def test_study_plan_uses_ai_package() -> None:
    response = client.post(
        "/api/v1/study-plan",
        json={
            "student_id": "demo",
            "results": [
                {"subject": "Türkçe", "correct": 30, "incorrect": 4, "blank": 6},
                {"subject": "Matematik", "correct": 10, "incorrect": 8, "blank": 22},
            ],
        },
    )

    assert response.status_code == 200
    assert response.json()["recommendations"][0]["subject"] == "Matematik"
