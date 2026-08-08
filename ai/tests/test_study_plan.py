import unittest

from ai.study_plan import generate_study_plan


class StudyPlanTests(unittest.TestCase):
    def test_weakest_subject_is_first(self) -> None:
        plan = generate_study_plan(
            [
                {"subject": "Türkçe", "correct": 30, "incorrect": 4, "blank": 6},
                {"subject": "Matematik", "correct": 10, "incorrect": 8, "blank": 22},
            ]
        )

        self.assertEqual(plan[0]["subject"], "Matematik")
        self.assertEqual(plan[0]["net"], 8.0)
        self.assertGreater(plan[0]["weekly_minutes"], plan[1]["weekly_minutes"])

    def test_empty_exam_does_not_divide_by_zero(self) -> None:
        plan = generate_study_plan(
            [{"subject": "Deneme", "correct": 0, "incorrect": 0, "blank": 0}]
        )

        self.assertEqual(plan[0]["net"], 0.0)


if __name__ == "__main__":
    unittest.main()
