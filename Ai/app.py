from flask import Flask, request, jsonify
import numpy as np
import pandas as pd
import pickle

app = Flask(__name__)

# تحميل النموذج والبيانات
model = pickle.load(open("diseases_model.sav", "rb"))
dataset = pd.read_csv("dogfinal3.csv")

# الأعمدة والأمراض
symptoms_list = [col for col in dataset.columns if col != 'diseases']
disease_classes = dataset['diseases'].unique().tolist()

# جدول شدة الأعراض
severity_scores = {
    "caninedistemper": {
        'Excellent': ['difficultyinbreathing','seizures', 'depression'],
        'Good': ['fever', 'vomiting', 'paralysis', 'reducedappetite', 'coughing', 'dischargefromeyes',
                 'nasaldischarge', 'lethargy', 'sneezing', 'diarrhea', 'pain', 'skinsores',
                 'inflammation_eyes', 'anorexia'],
        'Fair': ['hyperkeratosis']
    },
    "rabies": {
        'Excellent': ['hydrophobia', 'seizures', 'paralysis', 'difficultyinswallowing',
                      'foamingatmouth', 'aggression', 'highlyexcitable'],
        'Good': ['fever', 'vomiting', 'reducedappetite', 'lethargy', 'lameness', 'irritable'],
        'Fair': ['pica','excesssalivation']
    },
    "leptospirosis": {'Excellent': ['difficultyinbreathing', 'jaundice', 'bloodinurine'],
                     'Good': ['fever', 'vomiting','reducedappetite', 'coughing', 'nasaldischarge',
                                 'lethargy', 'diarrhea', 'depression', 'weakness', 'stiffness', 'limping', 'dehydration'],
                     'Fair': ['increasedthirst', 'increasedurination', 'shivering', 'laziness', 'bloodinstool']},
    "kennelcough": {'Good': ['coughing', 'difficultyinbreathing', 'gagging'],
                     'Fair': ['fever', 'vomiting', 'reducedappetite', 'dischargefromeyes',
                                  'nasaldischarge', 'lethargy', 'sneezing', 'weakness', 'reversesneezing']},
    "kidneydisease" : {'Excellent': ['seizures', 'bloodinurine', 'depression'],
                     'Good': ['vomiting', 'reducedappetite', 'lethargy', 'diarrhea', 'weightloss', 'weakness', 'lameness', 'increasedthirst',
                                 'increasedurination', 'palegums', 'ulcersinmouth', 'badbreath'],
                     'Fair': [ 'decreasedthirst','decreasedurination']},
    "heartworm": {'Excellent': ['difficultyinbreathing', 'fainting', 'rapidheartbeat'],
                     'Good': ['coughing', 'reducedappetite', 'lethargy', 'weightloss', 'fatigue',
                                 'swollenbelly', 'laziness'],
                     'Fair': ['anemia']},
    "canineparvovirus": {'Excellent': ['rapidheartbeat', 'bloodystool', 'diarrhea', 'vomiting', 'dehydration'],
                     'Good': ['fever', 'reducedappetite', 'lethargy', 'depression', 'pain', 'inflammation_eyes',
                                 'anorexia', 'weightloss','weakness', 'inflammation_mouth'],
                     'Fair': ['vomiting', ' diarrhea']}
}

value_map = {'Excellent': 3, 'Good': 2, 'Fair': 1}
severity_table = pd.DataFrame(0, index=symptoms_list, columns=[d.title() for d in severity_scores.keys()])
for disease, levels in severity_scores.items():
    for level, symptoms in levels.items():
        for symptom in symptoms:
            if symptom in severity_table.index:
                severity_table.at[symptom, disease.title()] = value_map[level]

def classify_disease(symptoms, disease_name):
    count_3 = count_2 = count_1 = over = 0
    weight_3, weight_2, weight_1 = 0.5, 0.3, 0.2
    disease_col = disease_name.title()

    for symptom in symptoms:
        value = severity_table.at[symptom, disease_col] if symptom in severity_table.index else 0

        if value:
            over += 1
            if value == 3: count_3 += 1
            elif value == 2: count_2 += 1
            elif value == 1: count_1 += 1

    total_symptoms = (severity_table[disease_col] > 0).sum()
    if over and total_symptoms:
        score = round((count_3 / over * weight_3 + count_2 / over * weight_2 + count_1 / over * weight_1) * 100 * (count_3 / total_symptoms), 2)
    else:
        score = 0

    if count_3 > 0 or score >= 80:
        return score, "Poor"
    elif score >= 50:
        return score, "Fair"
    elif score >= 20:
        return score, "Good"
    else:
        return score, "Excellent"

@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.get_json()
        if not data:
            return jsonify({"error": "الرجاء إرسال بيانات الأعراض."}), 400

        input_vector = [float(data.get(symptom, 0)) for symptom in symptoms_list]
        symptoms_present = [symptom for symptom in symptoms_list if data.get(symptom, 0) in [1, "1", "true", True]]

        results = []
        for disease in disease_classes:
            score, prognosis = classify_disease(symptoms_present, disease)
            if score > 0:
                results.append({
                    "disease": disease,
                    "severity_score": score,
                    "prognosis": prognosis
                })

        results.sort(key=lambda x: x["severity_score"], reverse=True)
        if results:
            results[0]["most_likely"] = True

        return jsonify({
            "observed_symptoms": symptoms_present,
            "predictions": results,
            "message": "تم ترتيب الأمراض حسب أعلى نسبة تطابق"
        })

    except Exception as e:
        return jsonify({"error": f"حدث خطأ: {str(e)}"}), 500

# 🚀 لتشغيل السيرفر على localhost
if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5000, debug=True)
