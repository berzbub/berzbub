# app.py
# Flask backend server for Joblaw Pro-Bono Legal Matching Platform

from flask import Flask, request, jsonify
import sqlite3
from jag_logic import JAGCaseEvaluator

app = Flask(__name__)
DB_NAME = 'joblaw.db'

def init_db():
    with sqlite3.connect(DB_NAME) as conn:
        with open('schema.sql', 'r') as f:
            conn.executescript(f.read())

@app.route('/api/intake', methods=['POST'])
def case_intake():
    data = request.json
    client_alias = data.get('client_alias')
    bureaucratic_agency = data.get('bureaucratic_agency')
    case_details = data.get('case_details')
    
    # Evaluate case procedural merits using JAG logic
    evaluator = JAGCaseEvaluator(case_id=f"CASE-{client_alias}", jurisdiction=bureaucratic_agency)
    evaluation = evaluator.evaluate_precedent("Procedural Intake Compliance", True, 0.85)
    
    with sqlite3.connect(DB_NAME) as conn:
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO cases (client_alias, bureaucratic_agency, case_details, status) VALUES (?, ?, ?, ?)",
            (client_alias, bureaucratic_agency, case_details, evaluation["status"])
        )
        conn.commit()
        
    return jsonify({
        "status": "success",
        "evaluation": evaluation,
        "message": "Case logged and evaluated successfully."
    }), 201

if __name__ == '__main__':
    init_db()
    app.run(debug=True, port=5000)
