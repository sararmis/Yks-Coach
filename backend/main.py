from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field

from ai import generate_study_plan


class SubjectResult(BaseModel):
    subject: str = Field(min_length=1, max_length=80)
    correct: int = Field(ge=0)
    incorrect: int = Field(ge=0)
    blank: int = Field(ge=0)


class StudyPlanRequest(BaseModel):
    student_id: str = Field(min_length=1, max_length=100)
    results: list[SubjectResult] = Field(min_length=1)


class Recommendation(BaseModel):
    subject: str
    net: float
    priority: int
    weekly_minutes: int
    message: str


class StudyPlanResponse(BaseModel):
    student_id: str
    recommendations: list[Recommendation]


app = FastAPI(title="YKS Coach API", version="0.1.0")
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Geliştirme ortamı; üretimde uygulama alan adıyla sınırlandırılmalı.
    allow_credentials=False,
    allow_methods=["GET", "POST"],
    allow_headers=["*"],
)


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok"}


@app.post("/api/v1/study-plan", response_model=StudyPlanResponse)
def create_study_plan(payload: StudyPlanRequest) -> StudyPlanResponse:
    results = [result.model_dump() for result in payload.results]
    recommendations = generate_study_plan(results)  # type: ignore[arg-type]
    return StudyPlanResponse(
        student_id=payload.student_id,
        recommendations=[Recommendation(**item) for item in recommendations],
    )
