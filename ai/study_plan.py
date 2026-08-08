"""Öğrencinin deneme sonuçlarından açıklanabilir bir çalışma planı üretir."""

from __future__ import annotations

from typing import TypedDict


class SubjectResult(TypedDict):
    subject: str
    correct: int
    incorrect: int
    blank: int


class StudyRecommendation(TypedDict):
    subject: str
    net: float
    priority: int
    weekly_minutes: int
    message: str


def generate_study_plan(results: list[SubjectResult]) -> list[StudyRecommendation]:
    """Neti düşük derse daha fazla süre ayıran deterministik plan üretir.

    YKS net formülü: doğru - yanlış / 4. Öncelik 1 en acil derstir.
    Bu fonksiyon HTTP veya model sağlayıcısına bağlı değildir; backend tarafından
    doğrudan çağrılabilir ve ileride bir LLM çıktısıyla zenginleştirilebilir.
    """
    scored: list[tuple[SubjectResult, float, float]] = []
    for result in results:
        total = result["correct"] + result["incorrect"] + result["blank"]
        net = round(result["correct"] - result["incorrect"] / 4, 2)
        gap_ratio = (total - max(net, 0)) / total if total else 0
        scored.append((result, net, gap_ratio))

    scored.sort(key=lambda item: (-item[2], item[1], item[0]["subject"]))

    recommendations: list[StudyRecommendation] = []
    for index, (result, net, gap_ratio) in enumerate(scored, start=1):
        weekly_minutes = round((90 + 210 * gap_ratio) / 15) * 15
        recommendations.append(
            {
                "subject": result["subject"],
                "net": net,
                "priority": index,
                "weekly_minutes": weekly_minutes,
                "message": (
                    f"{result['subject']} için haftada {weekly_minutes} dakika çalış; "
                    "yanlış ve boş soruları konu bazında tekrar et."
                ),
            }
        )
    return recommendations
