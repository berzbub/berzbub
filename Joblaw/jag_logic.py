# jag_logic.py
# Judge Advocate General (JAG) Inspired Legal & Procedural Reasoning Engine

class JAGCaseEvaluator:
    def __init__(self, case_id: str, jurisdiction: str):
        self.case_id = case_id
        self.jurisdiction = jurisdiction
        self.audit_trail = []

    def evaluate_precedent(self, rule_name: str, conditions_met: bool, precedent_weight: float) -> dict:
        """Evaluates a legal rule or precedent under strict procedural standards."""
        evaluation = {
            "rule": rule_name,
            "passed": conditions_met,
            "weight": precedent_weight,
            "status": "SUSTAINED" if conditions_met and precedent_weight > 0.5 else "OVERRULED"
        }
        self.audit_trail.append(evaluation)
        return evaluation

    def generate_brief(self) -> str:
        """Generates a structured legal brief based on accumulated rule evaluations."""
        brief = f"--- JAG LEGAL BRIEF: {self.case_id} ({self.jurisdiction}) ---\n"
        for item in self.audit_trail:
            brief += f"Rule: {item['rule']} | Status: {item['status']} (Weight: {item['weight']})\n"
        return brief

if __name__ == "__main__":
    evaluator = JAGCaseEvaluator(case_id="JAG-2026-001", jurisdiction="UCMJ / General")
    evaluator.evaluate_precedent("Procedural Due Process", True, 0.9)
    evaluator.evaluate_precedent("Jurisdictional Compliance", True, 0.8)
    print(evaluator.generate_brief())
